provider "google" {
  credentials = "${file("apiadmin.json")}"
  project     = "${var.project_id}"
  region      = "${var.region}"
}

data "google_client_config" "default" {}

locals {
  project_id = "${length(var.project_id) > 0 ? var.project_id : data.google_client_config.default.project}"
}

module "network" {
    source       = "./modules/network"
    project_id   = local.project_id
    vpc_name     = var.vpc_name
    region       = var.region
    subnet = {
            name    = var.subnet_name
            cidr    = var.subnet_cidr
            region  = var.region
    }
    source_ranges = var.allowed_source_ranges
}

module "gce" {
    source        = "./modules/gce"
    project_id    = local.project_id
    instance_name = var.instance_name
    instance_type = var.instance_type
    instance_zone = "${var.region}-${var.zone}"
    vpc_name      = var.vpc_name
    subnet_name   = "${module.network.subnet_name}"
    tags          = ["${module.network.tag-allow-ssh-defined-range}", "${module.network.tag-allow-http-https-all}"]
    gce_ssh_pub_key_file = "${file("apiadmin.pem.pub")}"
}