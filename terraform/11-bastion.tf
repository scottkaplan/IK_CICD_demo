resource "aws_instance" "IK-bastion" {
  ami           = "ami-0082110c417e4726e"
  instance_type = "t3.medium"
  key_name = "IK"
  iam_instance_profile = "IK-ec2"
  subnet_id = "subnet-0f4c16c45b98ab17e"
  vpc_security_group_ids = ["sg-04ce72d63382afeb6"]

  tags = {
    Name = "IK-bastion"
  }

  provisioner "local-exec" {
    command = <<EOT
      /usr/bin/wget -O /tmp/config_bastion.sh https://raw.githubusercontent.com/scottkaplan/IK_CICD_demo/main/ansible/config_bastion.sh
      /bin/bash /tmp/config_bastion.sh
    EOT
  }
}