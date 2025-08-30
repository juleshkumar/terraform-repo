data "aws_ssm_parameter" "eks_ami" {
  name = "/aws/service/eks/optimized-ami/1.33/amazon-linux-2023/x86_64/standard/recommended/image_id"
}

data "terraform_remote_state" "kms" {
  backend = "s3"

  config = {
    bucket = var.backend_bucket
    key    = "${var.backend_path}/backend/kms"
    region = var.region
    #role_arn = var.role_arn
  }
}

data "terraform_remote_state" "eks" {
  backend = "s3"

  config = {
    bucket = var.backend_bucket
    key    = "${var.backend_path}/backend/eks"
    region = var.region
    #role_arn = var.role_arn
  }
}

resource "aws_launch_template" "eks_node_lt" {
  count       = 1
  name_prefix = "${var.customer_name}-${var.environment}-nodegroups-lt"
  description = "EKS node launch template."

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = var.ec2_root_volume_size
      volume_type           = "gp3"
      delete_on_termination = true
      encrypted             = true
      kms_key_id            = data.terraform_remote_state.kms.outputs.key_arn
    }
  }

  key_name = aws_key_pair.nodegroups_key.key_name

  image_id = data.aws_ssm_parameter.eks_ami.value

  monitoring {
    enabled = true
  }

  vpc_security_group_ids = [
    aws_security_group.node_group_sg.id,
    data.terraform_remote_state.eks.outputs.eks_cluster_sg_id
  ]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name                                        = "${var.customer_name}-${var.environment}-nodegroup"
      KubernetesCluster                           = var.cluster-name
      Environment                                 = var.environment
      "kubernetes.io/cluster/${var.cluster-name}" = "owned"
    }
  }

  user_data = base64encode(<<-EOT
    #!/bin/bash
    set -o xtrace

    cat <<EOF > /etc/eks/nodeadm.yaml
    apiVersion: node.eks.aws/v1alpha1
    kind: NodeConfig
    spec:
      cluster:
        name: ${data.terraform_remote_state.eks.outputs.eks_cluster_id}
        apiServerEndpoint: ${data.terraform_remote_state.eks.outputs.eks_cluster_endpoint}
        certificateAuthority: ${data.terraform_remote_state.eks.outputs.eks_cluster_certificate_authority}
        cidr: ${var.service_cidr}
    EOF

    # Initialize the node
    nodeadm init --config-source file:///etc/eks/nodeadm.yaml
  EOT
  )
}

output "launch_template_id" {
  description = "The ID of the launch template"
  value       = aws_launch_template.eks_node_lt[0].id
}
