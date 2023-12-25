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
      sudo yum -y install ansible
      mkdir /tmp/ansible
      cd /tmp/ansible; wget https://raw.githubusercontent.com/scottkaplan/IK_CICD_demo/main/ansible/dot_files.yaml
      cd /tmp/ansible; wget https://raw.githubusercontent.com/scottkaplan/IK_CICD_demo/main/ansible/jenkins.yaml
      cd /tmp/ansible; wget https://raw.githubusercontent.com/scottkaplan/IK_CICD_demo/main/ansible/kubectl.yaml
      cd /tmp/ansible; wget https://raw.githubusercontent.com/scottkaplan/IK_CICD_demo/main/ansible/packages.yaml
      sudo ansible-playbook /tmp/ansible/*.yaml
    EOT
  }
}