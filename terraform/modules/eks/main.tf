data "terraform_remote_state" "vpc_state" {
  backend = "s3"

  config = {
    bucket     = var.backend_bucket
    key        = "${var.backend_path}/backend/vpc"
    region     = var.region
    #role_arn   = var.role_arn
  }
}

data "terraform_remote_state" "kms" {
  backend = "s3"

  config = {
    bucket     = var.backend_bucket
    key        = "${var.backend_path}/backend/kms"
    region     = var.region
    #role_arn   = var.role_arn
  }
}

resource "aws_cloudwatch_log_group" "group" {
  name              = "/aws/eks/${var.cluster-name}/cluster"
  retention_in_days = 7
}

resource "aws_iam_role" "eks-iam-role" {
  name = "eks-${var.cluster-name}-iam-role"
  path = "/"

  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
  {
   "Effect": "Allow",
   "Principal": {
    "Service": "eks.amazonaws.com"
   },
   "Action": "sts:AssumeRole"
  }
 ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "eks_node_AmazonEBSCSIDriverPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = aws_iam_role.eks-iam-role.name
}

resource "aws_iam_role_policy_attachment" "eks_node_AmazonEFSCsiDriverPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
  role       = aws_iam_role.eks-iam-role.name
}

resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks-iam-role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-iam-role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly-EKS" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks-iam-role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks-iam-role.name
}

data "aws_caller_identity" "current" {}

data "tls_certificate" "example" {
  url = aws_eks_cluster.eks.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "example" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.example.certificates[0].sha1_fingerprint]
  url             = data.tls_certificate.example.url
}

resource "aws_security_group" "eks_allow_vpc_cidr" {
  name        = "${var.cluster-name}-allow-vpc-cidr"
  description = "Allow traffic from VPC CIDR"
  vpc_id      = data.terraform_remote_state.vpc_state.outputs.vpc_id

  ingress {
    description = "Allow all inbound traffic from VPC CIDR"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [data.terraform_remote_state.vpc_state.outputs.vpc_cidr_block]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "${var.cluster-name}-allow-vpc-cidr"
    "${var.cluster-name}" = "true"
  }
}

resource "aws_security_group" "eks_cluster_sg" {
  name        = "${var.cluster-name}-cluster-sg"
  description = "Security group for EKS cluster communication"
  vpc_id      = data.terraform_remote_state.vpc_state.outputs.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [data.terraform_remote_state.vpc_state.outputs.vpc_cidr_block]
  }

  ingress {
    description = "Allow NFS traffic from within the VPC"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.vpc_state.outputs.vpc_cidr_block]
  }

  ingress {
    description = "Allow HTTP traffic from within the VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.vpc_state.outputs.vpc_cidr_block]
  }

  ingress {
    description = "Allow SSH traffic from within the VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.vpc_state.outputs.vpc_cidr_block]
  }

  ingress {
    description = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
    from_port   = 1025
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.vpc_state.outputs.vpc_cidr_block]
  }

  ingress {
    description = "Allow worker to communicate with the cluster API server"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.vpc_state.outputs.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "${var.cluster-name}-cluster-sg"
  }
}

resource "aws_eks_cluster" "eks" {
  name                      = var.cluster-name
  role_arn                  = aws_iam_role.eks-iam-role.arn
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  version                   = var.k8s_version

  encryption_config {
    provider {
      key_arn = data.terraform_remote_state.kms.outputs.key_arn
    }
    resources = ["secrets"]
  }

  vpc_config {
    subnet_ids              = data.terraform_remote_state.vpc_state.outputs.private_subnet_ids
    endpoint_public_access  = false
    endpoint_private_access = true
    security_group_ids      = [aws_security_group.eks_allow_vpc_cidr.id, aws_security_group.eks_cluster_sg.id]
  }

  access_config {
    authentication_mode                         = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }

  depends_on = [
    aws_iam_role.eks-iam-role,
    aws_cloudwatch_log_group.group,
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
    aws_iam_role_policy_attachment.eks_cluster_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly-EKS,
    aws_iam_role_policy_attachment.eks_node_AmazonEBSCSIDriverPolicy,
    aws_iam_role_policy_attachment.eks_node_AmazonEFSCsiDriverPolicy
  ]

  tags = var.eks_tags
}