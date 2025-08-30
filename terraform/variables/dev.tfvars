

backend_bucket = "terrafrom-backend-bucket-gyanbharatam"

backend_path = "UAT"


customer_name = "gyan-bharatam-uat"

account_id = "789814231858"

bucket_name = "gyan-bharatam-uat"

s3_tags = {environment = "UAT"}

vpc_cidr = "10.83.0.0/16"

public_subnet_1_cidr = "10.83.0.0/20"

public_subnet_2_cidr = "10.83.16.0/20"

public_subnet_3_cidr = "10.83.32.0/20"

private_subnet_1_cidr = "10.83.48.0/20"

private_subnet_2_cidr = "10.83.64.0/20"

private_subnet_3_cidr = "10.83.80.0/20"


vpc_tags = {environment = "UAT"}

lb_tags = {environment = "UAT"}


eks_tags = {environment = "UAT"}



jumpbox_tags = {environment = "UAT"}

rds_tags  = {environment = "UAT"}


environment = "UAT"

region = "ap-south-1"

kms_key_name = "gyan-bharatam-uat-cmk"

kms_tags = {environment = "UAT"}

cluster-name = "gyan-bharatam-uat"


cloudwatch_logs = false

cluster-autoscaler = false

ec2_root_volume_size = "20"

nodegroup_name = "managed-nodegroup-test"

service_cidr = "172.20.0.0/16"

node_groups_test_tt = [
  {
    name           = "managed-nodegroup-test"
    instance_types = ["t3a.medium", "t3.medium"]
    ng_test_tags = {
      map-migrated: "mig4I96YDPBNH"
    }
    labels = {
      prod = "true"
    }
    minimum_size   = 1
    maximum_size   = 6
    desired_size   = 1
    capacity_type  = "ON_DEMAND"
  }
]


###############EKS-ADDON##############################
coredns_version              = "v1.12.1-eksbuild.2"
kube_proxy_version           = "v1.33.0-eksbuild.2"
pod_identity_agent_version   = "v1.3.8-eksbuild.2"
ebs_csi_driver_version       = "v1.48.0-eksbuild.1"
efs_csi_driver_version       = "v2.1.10-eksbuild.1"
vpc_cni_version              = "v1.19.5-eksbuild.1"


k8s_version = "1.33"

ami = "ami-0e639fddd264584f2"


ec2_key_name = "jumpbox-key-ec2"

ec2_instance_type = "t4g.small"


elasticsearch_user = "ec2-elasticsearch-user"
elasticsearch_ec2_instance_type = "t4g.small"
elasticsearch_ami = "ami-0fad8318b9405c6fb"
elasticsearch_tags = {environment = "UAT"}

gyan_bharatam_db_instance_identifier = "gyan-bharatam-uat"

gyan_bharatam_db_security_group = "gyan-bharatam-uat-sg"


major_version = "16"

gyan_bharatam_db_allocated_storage = "20"

engine_version = "16.10"

gyan_bharatam_db_instance_type = "db.t4g.small"

gyan_bharatam_database_name = "gyan_bharatam_uat"

rds_secret_name = "psql"

rds_port = 5432

rds_multi_az = false

js_user = "ec2-js-user"

eks_key_name = "eks-key"



