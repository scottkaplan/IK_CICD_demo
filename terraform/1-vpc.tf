resource "aws_vpc" "IK" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "IK"
  }
}
