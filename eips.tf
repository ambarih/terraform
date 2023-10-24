resource "aws_eip" "nat1" {
  depends_on = [aws_internet_gateway.main]
  tags = {
    Name        = "NAT 1"
    Project     = "Jarvis"
    Environment = "Test"
    Owner       = "agangulappa@altimetrik.com"
    Application = "Web"
  }

}
resource "aws_eip" "nat2" {
  depends_on = [aws_internet_gateway.main]
  tags = {
    Name        = "NAT 2"
    Project     = "Jarvis"
    Environment = "Test"
    Owner       = "agangulappa@altimetrik.com"
    Application = "Web"
  }

}