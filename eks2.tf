# provider "aws" {
#   region = "us-west-2"  # Replace with your desired AWS region
# }

resource "aws_eks_cluster" "example_cluster" {
  name     = "example-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  tags = {
    Name        = "example_cluster"
    Project     = "Jarvis"
    Environment = "Test"
    Owner       = "agangulappa@altimetrik.com"
    Application = "Web"
  }

  version = "1.27"

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access  = true
    subnet_ids              = [
      aws_subnet.public_1.id,
      aws_subnet.public_2.id,
      aws_subnet.private_1.id,
      aws_subnet.private_2.id
    ]
  }
}

resource "aws_eks_node_group" "example_node_group" {
  cluster_name    = aws_eks_cluster.example_cluster.name
  node_group_name = "example-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]

  tags = {
    Name        = "node_group"
    Project     = "Jarvis"
    Environment = "Test"
    Owner       = "agangulappa@altimetrik.com"
    Application = "Web"
  }

  scaling_config {
    desired_size = 1
    min_size     = 1
    max_size     = 1
  }
}

resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role"

  tags = {
    Name        = "eks_cluster_role"
    Project     = "Jarvis"
    Environment = "Test"
    Owner       = "agangulappa@altimetrik.com"
    Application = "Web"
  }

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  # Attach the Amazon EKS Cluster Policy and Amazon EKS Service Policy
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
    "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  ]
}

resource "aws_iam_role" "eks_node_role" {
  name = "eks-node-role"

  tags = {
    Name        = "eks_node_role"
    Project     = "Jarvis"
    Environment = "Test"
    Owner       = "agangulappa@altimetrik.com"
    Application = "Web"
  }

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  # Attach the Amazon EKS Worker Node Policy and Amazon EC2 Container Registry ReadOnly Policy
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ]
}

resource "aws_lb" "example_load_balancer" {
  name               = "example-load-balancer"
  load_balancer_type = "network"
  internal           = true

  subnets = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]

  tags = {
    Name        = "example-load-balancer"
    Project     = "Jarvis"
    Environment = "Test"
    Owner       = "agangulappa@altimetrik.com"
    Application = "Web"
  }
}

resource "aws_eks_node_group" "nodes_general" {
  cluster_name   = aws_eks_cluster.example_cluster.name
  node_group_name = "nodes-general"
  node_role_arn   = aws_iam_role.eks_node_role.arn

  subnet_ids = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  ami_type              = "AL2_x86_64"
  capacity_type         = "ON_DEMAND"
  disk_size             = 20
  force_update_version  = false
  instance_types        = ["t3.small"]
  labels = {
    role = "nodes-general"
  }
  version = "1.27"

  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_worker_node_policy,
    aws_iam_role_policy_attachment.amazon_eks_cni_policy,
    aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only,
  ]

  tags = {
    Name        = "node"
    Project     = "Jarvis"
    Environment = "Test"
    Owner       = "agangulappa@altimetrik.com"
    Application = "Web"
  }
}

resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_role.name
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node_role.name
}

resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_node_role.name
}
