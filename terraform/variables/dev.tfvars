#azs = ["us-east-1a", "us-east-1b"]

#azs = length(data.aws_availability_zones.available.names)

backend_bucket = "terrafrom-backend-bucket-gyanbharatam"

backend_path = "UAT"

role_arn = "arn:aws:iam::975050085624:role/terraform-testing"

customer_name = "gyan-bharatam-uat"

account_id = "789814231858"

bucket_name = "gyan-bharatam-uat"

s3_tags = {Environment = "UAT", map-migrated: "mig4I96YDPBNH"}

vpc_cidr = "10.83.0.0/16"

public_subnet_1_cidr = "10.83.0.0/20"

public_subnet_2_cidr = "10.83.16.0/20"

public_subnet_3_cidr = "10.83.32.0/20"

private_subnet_1_cidr = "10.83.48.0/20"

private_subnet_2_cidr = "10.83.64.0/20"

private_subnet_3_cidr = "10.83.80.0/20"


vpc_tags = {Environment = "UAT"}

lb_tags = {Environment = "UAT"}



elasticache_tags = {Environment = "UAT"}

eks_tags = {Environment = "UAT", map-migrated: "mig4I96YDPBNH"}

efs_tags = {Environment = "UAT"}

jumpbox_tags = {Environment = "UAT", map-migrated: "mig4I96YDPBNH"}

rds_tags  = {Environment = "UAT", map-migrated: "mig4I96YDPBNH"}

public-count = 2

private-count = 2

nat-count = 2

public-subnet_mask = 4

private-subnet_mask = 4

environment = "UAT"

region = "ap-south-1"

internal = false

load_balancer_type = "application"

load_balancer_name = "decimal-load-balancer"

security_group = "vpc-sg"

lb-port = 30023

protocol = "HTTP"

target-group-name = "tg-sg-lb"

lb_security_group = "load-balancer-sg"

from_ports = 443

to_ports = 443

security-group-cidr = "0.0.0.0/0"

kms_key_name = "gyan-bharatam-uat-cmk"

kms_tags = {Environment = "UAT"}

cluster-name = "gyan-bharatam-uat"

tool-max-workers-decimal1 = "2"

app-max-workers-decimal0 = "2"

nginx-max-workers-decimal2 = "2"

cust-app-max-workers-decimal3 = "2"

redis-max-workers-decimal4 = "2"

observability-max-workers-decimal5 = "2"

cloudwatch_logs = false

cluster-autoscaler = false

node_groups_decimal0 = [{ name = "pt-gf" }]

node_groups_decimal1 = [{ name = "pt-gf1" }]

node_groups_decimal2 = [{ name = "pt-gf" }]

node_groups_decimal3 = [{ name = "pt-gf1" }]

node_groups_decimal4 = [{ name = "pt-gf" }]

node_groups_decimal5 = [{ name = "pt-gf1" }]
count_decimal0 = 1
count_decimal1 = 1
count_decimal2 = 1
count_decimal3 = 1
count_decimal4 = 1
count_decimal5 = 1

node-ami-decimal0 = "ami-0f403e3180720dd7e"
node-ami-decimal1 = "ami-0f403e3180720dd7e"

instance_capacity_types_decimal1 = "ON_DEMAND"

instance_capacity_types_decimal0 = "ON_DEMAND"

instance_capacity_types_decimal3 = "ON_DEMAND"

instance_capacity_types_decimal2 = "ON_DEMAND"

instance_capacity_types_decimal4 = "ON_DEMAND"

instance_capacity_types_decimal5 = "ON_DEMAND"

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

inst_key_pair = null

app-min-workers-decimal0 = "1"

tool-min-workers-decimal1 = "1"

nginx-min-workers-decimal2 = "1"

cust-app-min-workers-decimal3 = "1"

redis-min-workers-decimal4 = "1"

observability-min-workers-decimal5 = "1"

app-desired-workers-decimal0 = "1"

tool-desired-workers-decimal1 = "1"

nginx-desired-workers-decimal2 = "1"

cust-app-desired-workers-decimal3 = "1"

redis-desired-workers-decimal4 = "1"

observability-desired-workers-decimal5 = "1"

k8s_version = "1.33"

instance-type-on-decimal1 = ["t3.medium", "t2.micro"]

instance-type-decimal0 = ["t3.medium", "t2.micro"]

instance-type-decimal2 = ["t3.medium", "t2.micro"]

instance-type-on-decimal3 = ["t3.medium", "t2.micro"]

instance-type-decimal4 = ["t3.medium", "t2.micro"]

instance-type-decimal5 = ["t3.medium", "t2.micro"]

public_key_file = "~/.ssh/id_rsa.pub"

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

efs-security-group = "efs-mount-target-sg"

replication-id = "decimal-elasticache-replication"

redis-cluster = "elasticache-redis-cluster"
redis-engine = "REDIS"

redis-engine-version = "7.0"

redis_password = "samepasswprdforredis"

redis-node-type = "cache.t3.small"

redis-user-name = "default"

transit_encryption_enabled = true

redis-user-id = "redis-user-dc"

redis-user-group = "test-user"

rest_encryption = true

num-cache-nodes = "1"

redis_multi_az = true

redis_auto_failover = true

parameter-group-family = "redis7"

num-node-groups = "1"

replicas-per-node-group = "1"

redis_port = 6379

js_user = "ec2-js-user"

eks_key_name = "eks-key"



