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
    bucket   = var.backend_bucket
    key      = "${var.backend_path}/backend/kms"
    region   = var.region
    #role_arn   = var.role_arn
  }
}


#IAM USER 

resource "aws_iam_role" "js-iam-role" {
  name = "eks-${var.elasticsearch_user}-iam-role"

  path = "/"

  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
  {
   "Effect": "Allow",
   "Principal": {
    "Service": "ec2.amazonaws.com"
   },
   "Action": "sts:AssumeRole"
  }
 ]
}
EOF

}



resource "aws_iam_role_policy_attachment" "elasticsearch_user_ec2_policy_attachment" {
  role       = aws_iam_role.js-iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_role_policy_attachment" "elasticsearch_user_ssm_policy_attachment" {
  role       = aws_iam_role.js-iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

resource "aws_iam_role_policy_attachment" "elasticsearch_user_efs_policy_attachment" {
  role       = aws_iam_role.js-iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonElasticFileSystemFullAccess"
}

resource "aws_iam_role_policy_attachment" "elasticsearch_user_eks_policy_attachment" {
  role       = aws_iam_role.js-iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "elasticsearch_user_elasticache_policy_attachment" {
  role       = aws_iam_role.js-iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonElastiCacheFullAccess"
}

resource "aws_iam_role_policy_attachment" "elasticsearch_user_rds_policy_attachment" {
  role       = aws_iam_role.js-iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}

resource "aws_iam_role_policy_attachment" "elasticsearch_user_s3_policy_attachment" {
  role       = aws_iam_role.js-iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "elasticsearch_user_vpc_policy_attachment" {
  role       = aws_iam_role.js-iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
}



resource "tls_private_key" "elasticsearch_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "elasticsearch_key" {
  key_name   = "${var.customer_name}-${var.environment}-elasticsearch-keypair"
  public_key = tls_private_key.elasticsearch_private_key.public_key_openssh
}

resource "aws_ssm_parameter" "elasticsearch_private_key_ssm" {
  name        = "/${var.environment}/ec2-keypairs/${var.customer_name}-${var.environment}-elasticsearch-keypair"
  type        = "SecureString"
  value       = tls_private_key.elasticsearch_private_key.private_key_pem
  description = "Private key for ${var.customer_name}-${var.environment}-elasticsearch-keypair"
  overwrite   = true
  key_id      = data.terraform_remote_state.kms.outputs.key_arn

  tags = {
    Environment = var.environment
    Customer    = var.customer_name
  }
}


resource "aws_security_group" "securitygroup-jump" {
  name        = "elasticsearch-elasticsearch-alpha"
  description = "Default SG to allow traffic from the VPC mysg"
  vpc_id      = data.terraform_remote_state.vpc_state.outputs.vpc_id

  # Ingress rules
  ingress {
    from_port   = 22 # SSH port
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow EKS control plane access 
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow access to RDS 
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.vpc_state.outputs.vpc_cidr_block]
  }

  # Allow access to ElastiCache elasticsearch 
  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"          # All protocols
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }
}

locals {
  constant_elasticsearch_instance_tags = {
    Name        = "${var.customer_name}-${var.environment}-eks-elasticsearch"
    ManagedBy   = "Terraform"
  }
}


resource "aws_instance" "master" {
  ami                  = var.elasticsearch_ami
  instance_type        = var.elasticsearch_ec2_instance_type
  key_name             = aws_key_pair.elasticsearch_key.key_name
  subnet_id            = data.terraform_remote_state.vpc_state.outputs.private_subnet_ids[0]
  security_groups      = ["${aws_security_group.securitygroup-jump.id}"]
  iam_instance_profile = aws_iam_instance_profile.js_instance_profile.name
  associate_public_ip_address = false  # ensure NO public IP


  # Enforce IMDSv2
  metadata_options {
    http_endpoint               = "enabled"   # metadata endpoint must be enabled
    http_tokens                 = "required"  # force IMDSv2, disable IMDSv1
    http_put_response_hop_limit = 1           # default, can adjust if needed
  }

  root_block_device {
    volume_size           = 20
    encrypted             = true
    kms_key_id            = data.terraform_remote_state.kms.outputs.key_arn
    delete_on_termination = true
  }

    tags = merge(
    local.constant_elasticsearch_instance_tags,
    var.elasticsearch_tags
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_instance_profile" "js_instance_profile" {
  name = "${var.elasticsearch_user}-instance-profile"
  role = aws_iam_role.js-iam-role.name
}



#resource "local_file" "ssh_key" {
 # filename = "${aws_key_pair.main.key_name}.pem"
  #content  = tls_private_key.ssh_server.private_key_pem
#}
