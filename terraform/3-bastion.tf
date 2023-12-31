resource "aws_security_group" "bastion" {
  name        = "bastion"
  description = "Allow SSH, HTTP(S), Jenkins"
  vpc_id      = aws_vpc.IK.id

  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Jenkins"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "bastion"
  }
}

data "aws_ami" "base_ami" {
  most_recent      = true
  owners           = ["amazon"]
 
  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
 
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
 
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
 
}

resource "aws_instance" "IK-bastion" {
  ami           = data.aws_ami.base_ami.id
  instance_type = "t3.medium"
  key_name = "IK"
  iam_instance_profile = "IK-ec2"
  subnet_id = aws_subnet.public-us-west-1a.id
  vpc_security_group_ids = [aws_security_group.bastion.id]

  tags = {
    Name = "IK-bastion"
  }

  connection {
    type = "ssh"
    host = aws_instance.IK-bastion.public_ip
    user = "ec2-user"
    private_key = "${file(var.ssh_private_key_file)}"
    agent = true
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir /home/ec2-user/.aws",
      "/usr/bin/wget -O /tmp/config_bastion.sh https://raw.githubusercontent.com/scottkaplan/IK_CICD_demo/main/ansible/config_bastion.sh",
      "/bin/bash /tmp/config_bastion.sh"
    ]
  }

  provisioner "file" {
    source = var.aws_credentials_file
    destination = "/home/ec2-user/.aws/credentials"
  }

}

data "aws_route53_zone" "kaplans" {
  name = "kaplans.com"
}

resource "aws_route53_record" "ik-bastion" {
  zone_id = data.aws_route53_zone.kaplans.zone_id
  name    = "ik-bastion.kaplans.com"
  type    = "A"
  ttl     = 300
  records = [aws_instance.IK-bastion.public_ip]
}

resource "aws_route53_record" "ik-jenkins" {
  zone_id = data.aws_route53_zone.kaplans.zone_id
  name    = "ik-jenkins.kaplans.com"
  type    = "A"
  ttl     = 300
  records = [aws_instance.IK-bastion.public_ip]
}