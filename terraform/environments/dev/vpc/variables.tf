variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_1_cidr" {
  description = "CIDR block for the first public subnet"
  type        = string
}

variable "public_subnet_2_cidr" {
  description = "CIDR block for the second public subnet"
  type        = string
}

variable "public_subnet_3_cidr" {
  description = "CIDR block for the third public subnet"
  type        = string
}

variable "private_subnet_1_cidr" {
  description = "CIDR block for the first private subnet"
  type        = string
}

variable "private_subnet_2_cidr" {
  description = "CIDR block for the second private subnet"
  type        = string
}

variable "private_subnet_3_cidr" {
  description = "CIDR block for the third private subnet"
  type        = string
}


variable "vpc_tags" {
  description = "Tags for the VPC"
  type        = map(string)
}

variable "environment" {
  type        = string
  description = "Environment for vpc"
}

variable "cluster-name" {
  description = "The name of the cluster"
  type        = string
}

variable "customer_name" {
  description = "Enter name of the customer"
  type        = string
}