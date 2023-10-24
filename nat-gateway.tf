resource "aws_nat_gateway" "gw1" {
  #allocation of elastic ip adress for the gateway
  allocation_id = aws_eip.nat1.id

  # the subent id of the subnet in which to place the gateway
  subnet_id = aws_subnet.public_1.id
  tags = {
    Name        = "NAT_1"
    Project     = "Jarvis"
    Environment = "Test"
    Owner       = "agangulappa@altimetrik.com"
    Application = "Web"
  }
}


resource "aws_nat_gateway" "gw2" {
  #allocation of elastic ip adress for the gateway
  allocation_id = aws_eip.nat2.id

  # the subent id of the subnet in which to place the gateway
  subnet_id = aws_subnet.public_2.id
  tags = {
    Name        = "NAT_2"
    Project     = "Jarvis"
    Environment = "Test"
    Owner       = "agangulappa@altimetrik.com"
    Application = "Web"
  }
}