resource "aws_internet_gateway" "IK-igw" {
  vpc_id = aws_vpc.IK.id

  tags = {
    Name = "IK-igw"
  }
}
