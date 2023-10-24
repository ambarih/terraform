# # provider "aws" {
# #   region = "us-west-2"  # Replace with your desired AWS region
# # }

# resource "aws_eks_cluster" "example_cluster" {
#   name     = "example-cluster"
#   role_arn = aws_iam_role.eks_cluster_role.arn

#   tags = {
#     Name        = "example_cluster"
#     Project     = "Jarvis"
#     Environment = "Test"
#     Owner       = "agangulappa@altimetrik.com"
#     Application = "Web"

#   }
#   version = "1.27"
#   vpc_config {
#     # Indicates whether or not the Amazon EKS private API server endpoint is enable
#     endpoint_private_access = false
#     # Indicates whether or not the Amazon EKS public API server endpoint is enabled
#     endpoint_public_access = true
#     # Must be in at least two different availability zones
#     subnet_ids = [
#       aws_subnet.public_1.id,
#       aws_subnet.public_2.id,
#       aws_subnet.private_1.id,
#       aws_subnet.private_2.id
#     ]
#   }
# }



# resource "aws_eks_node_group" "example_node_group" {
#   cluster_name    = aws_eks_cluster.example_cluster.name
#   node_group_name = "example-node-group"
#   node_role_arn   = aws_iam_role.eks_node_role.arn
#   subnet_ids = [
#     aws_subnet.private_1.id,
#     aws_subnet.private_2.id
#   ]

#   tags = {
#     Name        = "node_group"
#     Project     = "Jarvis"
#     Environment = "Test"
#     Owner       = "agangulappa@altimetrik.com"
#     Application = "Web"

#   }

#   scaling_config {
#     desired_size = 1
#     min_size     = 1
#     max_size     = 1
#   }
# }

# resource "aws_iam_role" "eks_cluster_role" {
#   name = "eks-cluster-role"

#   # Attach tags to the IAM role
#   tags = {
#     Name        = "eks_cluster_role"
#     Project     = "Jarvis"
#     Environment = "Test"
#     Owner       = "agangulappa@altimetrik.com"
#     Application = "Web"
#   }

#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Sid": "",
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "eks.amazonaws.com"
#       },
#       "Action": "sts:AssumeRole"
#     }
#   ]
# }
# EOF

#   # Attach the Amazon EKS Cluster Policy
#   managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"]
# }


# resource "aws_iam_role" "eks_node_role" {
#   name = "example-eks-node-role"

#   # Attach tags to the IAM role
#   tags = {
#     Name        = "eks_node_role"
#     Project     = "Jarvis"
#     Environment = "Test"
#     Owner       = "agangulappa@altimetrik.com"
#     Application = "Web"
#   }

#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Sid": "",
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "ec2.amazonaws.com"
#       },
#       "Action": "sts:AssumeRole"
#     }
#   ]
# }
# EOF

#   # Attach the Amazon EKS Worker Node Policy
#   managed_policy_arns = [
#     "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
#     "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
#   ]
# }

