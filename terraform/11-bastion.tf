resource "aws_instance" "IK-bastion" {
  ami           = "ami-0082110c417e4726e"
  instance_type = "t3.micro"
  key_name = "IK"
  iam_instance_profile = "IK-ec2"
  subnet_id = "subnet-0f4c16c45b98ab17e"
  vpc_security_group_ids = ["sg-04ce72d63382afeb6"]

  tags = {
    Name = "IK-bastion"
  }
}