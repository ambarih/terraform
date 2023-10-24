resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name                        = "public-us-east-1a"
    "kubernates.io/cluster/eks" = "shared"
    "kubernates.io/role/elb"    = 1
    Project                     = "Jarvis"
    Environment                 = "Test"
    Owner                       = "agangulappa@altimetrik.com"
    Application                 = "Web"
  }
}



resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name                        = "public-us-east-1b"
    "kubernates.io/cluster/eks" = "shared"
    "kubernates.io/role/elb"    = 1
    Project                     = "Jarvis"
    Environment                 = "Test"
    Owner                       = "agangulappa@altimetrik.com"
    Application                 = "Web"
  }
}


resource "aws_subnet" "private_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"

  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name                             = "private-us-east-1a"
    "kubernates.io/cluster/eks"      = "shared"
    "kubernates.io/role/interna-elb" = 1
    Project                          = "Jarvis"
    Environment                      = "Test"
    Owner                            = "agangulappa@altimetrik.com"
    Application                      = "Web"
  }
}

resource "aws_subnet" "private_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name                              = "private-us-east-1b"
    "kubernates.io/cluster/eks"       = "shared"
    "kubernates.io/internal-role/elb" = 1
    Project                           = "Jarvis"
    Environment                       = "Test"
    Owner                             = "agangulappa@altimetrik.com"
    Application                       = "Web"
  }
}