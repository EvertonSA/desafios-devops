variable "project_id" {
  description = "The project ID to host the Instance in"
}

variable "instance_name" {
  description = " The name of the instance."
}

variable "instance_type" {
  description = "The machine type to create."
}

variable "instance_zone" {
  description = "The zone of the instance."
}

variable "vpc_name" {
  description = "The name or self_link of the network attached to this interface."
}

variable "subnet_name" {
  description = "The name or self_link of the subnetwork attached to this interface."
}

variable "tags" {
  description = "The list of tags attached to the instance."
  default = [""]
}

variable "gce_ssh_user" {
  description = "The list of tags attached to the instance."
  default = "apiadmin"
}

variable "gce_ssh_pub_key_file" {
  description = "The list of tags attached to the instance."
  default = ""
}