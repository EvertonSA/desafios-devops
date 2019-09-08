# dear Idwall engineer, the bellow is bad. I know. There maybe 1000 ways of doing this in a better way, but terraform is not in my "to specialize" list
# don't get me wrong, I love terraform. IaaS rocks. But I'm way more into Kubernetes than IaaS.

data "google_client_config" "default" {}

locals {
  project-id = "${length(var.project_id) > 0 ? var.project_id : data.google_client_config.default.project}"
}

resource "google_compute_instance" "default" {
  project       = "${local.project-id}"
  name          = "${var.instance_name}"
  machine_type  = "${var.instance_type}"
  zone          = "${var.instance_zone}"
  network_interface {
    network     = "${var.vpc_name}"
    subnetwork  = "${var.subnet_name}"
    access_config {
    }
  }
  boot_disk {
    initialize_params {
      image = "centos-7"
    }
  }
  tags = var.tags
  
  metadata = {
    ssh-keys = "${var.gce_ssh_user}:${var.gce_ssh_pub_key_file}"
  }
}