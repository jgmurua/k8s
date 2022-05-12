variable "cluster_name" {
  type    = string
  default = "k0scluster"
}

variable "controller_count" {
  type    = number
  default = 1
}

variable "worker_count" {
  type    = number
  default = 5
}

variable "cluster_flavor" {
  type    = string
  default = "t3a.xlarge"
}

variable "controlerflavour" {
  type    = string
  default = "t3a.xlarge"
}

variable "spot_price" {
  type    = string
  default = "0.23"
}

variable "ebs_size" {
  default = 100
}

variable "availability_zone" {
  type    = string
  default = "us-east-2c"
}

variable "region" {
  type    = string
  default = "us-east-2"
}

variable "vpc_id" {
  type    = string
  default = "VPC"
}


variable "private_subnet_id" {
  type    = string
  default = "SUBNET"
}
