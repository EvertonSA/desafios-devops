variable "project_id" {
  type    = "string"
#  default = "sandbox-216902"
}

variable "region" {
  type = "string"
#  default = "us-central1"
}

variable "zone" {
  type = "string"
#  default = "a"
}

variable "allowed_source_ranges" {
  type = "list"
#  default = ["0.0.0.0/0", "192.168.0.22/32"]
}

variable "vpc_name" {
  type = "string"
  default = "best-vpc-name"
}

variable "subnet_name" {
  type = "string"
  default = "best-subnet-name"
}

variable "subnet_cidr" {
  type = "string"
  default = "10.0.32.0/24"
}

variable "instance_name" {
  type = "string"
  default = "amazing-idwall-vm"
}

variable "instance_type" {
  type = "string"
  default = "n1-standard-1"
}