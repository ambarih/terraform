# # Create IAM role for EKS cluster
# resource "aws_iam_role" "example_eks_cluster_role" {
#   name = "example-eks-cluster-role"

#   assume_role_policy = <<POLICY
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "eks.amazonaws.com"
#       },
#       "Action": "sts:AssumeRole"
#     }
#   ]
# }
# POLICY

#   tags = {
#     Name        = "example-eks-cluster-role"
#     Project     = "Jarvis"
#     Environment = "Test"
#     Owner       = "agangulappa@altimetrik.com"
#     Application = "Web"
#   }
# }

# resource "aws_iam_role_policy_attachment" "example_eks_cluster_role_policy_attachment" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
#   role       = aws_iam_role.example_eks_cluster_role.name
# }

# resource "aws_lb" "example_load_balancer" {
#   name               = "example-load-balancer"
#   load_balancer_type = "network"
#   internal           = true

#   subnets = [
#     aws_subnet.private_1.id,
#     aws_subnet.private_2.id
#   ]

#   tags = {
#     Name        = "example-load-balancer"
#     Project     = "Jarvis"
#     Environment = "Test"
#     Owner       = "agangulappa@altimetrik.com"
#     Application = "Web"
#   }
# }

# resource "aws_eks_node_group" "nodes_general" {
#   cluster_name    = aws_eks_cluster.example_cluster.name
#   node_group_name = "nodes-general"
#   node_role_arn   = aws_iam_role.nodes_general.arn

#   subnet_ids = [
#     aws_subnet.private_1.id,
#     aws_subnet.private_2.id
#   ]

#   scaling_config {
#     desired_size = 1
#     max_size     = 1
#     min_size     = 1
#   }

#   ami_type              = "AL2_x86_64"
#   capacity_type         = "ON_DEMAND"
#   disk_size             = 20
#   force_update_version  = false
#   instance_types        = ["t3.small"]
#   labels = {
#     role = "nodes-general"
#   }
#   version = "1.27"

#   depends_on = [
#     aws_iam_role_policy_attachment.amazon_eks_worker_node_policy_general,
#     aws_iam_role_policy_attachment.amazon_eks_cni_policy_general,
#     aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only,
#     aws_iam_role_policy_attachment.example_eks_cluster_role_policy_attachment,
#   ]

#   tags = {
#     Name        = "node"
#     Project     = "Jarvis"
#     Environment = "Test"
#     Owner       = "agangulappa@altimetrik.com"
#     Application = "Web"
#   }
# }

# # Existing resources
# resource "aws_iam_role" "nodes_general" {
#   name = "eks-role-node"

#   tags = {
#     Name        = "eks-role-node"
#     Project     = "Jarvis"
#     Environment = "Test"
#     Owner       = "agangulappa@altimetrik.com"
#     Application = "Web"
#   }

#   assume_role_policy = <<POLICY
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "ec2.amazonaws.com"
#       },
#       "Action": "sts:AssumeRole"
#     }
#   ]
# }
# POLICY
# }

# resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy_general" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
#   role       = aws_iam_role.nodes_general.name
# }

# resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy_general" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
#   role       = aws_iam_role.nodes_general.name
# }

# resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
#   role       = aws_iam_role.nodes_general.name
# }
