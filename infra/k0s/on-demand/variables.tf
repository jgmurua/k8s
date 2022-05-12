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
  default = 2
}

variable "cluster_flavor" {
  type    = string
  default = "t3a.medium"
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
