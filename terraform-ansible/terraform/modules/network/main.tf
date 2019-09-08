# dear Idwall engineer, the bellow is bad. I know. There maybe 1000 ways of doing this in a better way, but terraform is not in my "to specialize" list
# don't get me wrong, I love terraform. IaaS rocks. But I'm way more into Kubernetes than IaaS.

data "google_client_config" "default" {}

locals {
  project-id = "${length(var.project_id) > 0 ? var.project_id : data.google_client_config.default.project}"
}

resource "google_compute_network" "default" {
    name                    = "${var.vpc_name}"
    project                 = "${local.project-id}"
    auto_create_subnetworks = "${var.auto_create_subnetworks}"
    routing_mode            = "${var.routing_mode}"
}

resource "google_compute_subnetwork" "default" {
    project       = "${local.project-id}"
    name          = "${var.subnet.name}" 
    ip_cidr_range = "${var.subnet.cidr}"
    region        = "${var.subnet.region}"
    network       = "${var.vpc_name}"
    private_ip_google_access  = "${var.private_ip_google_access}"
    enable_flow_logs          = "${var.enable_flow_logs}"
    depends_on = [google_compute_network.default]
}

resource "google_compute_firewall" "ssh" {
  name    = var.tag-allow-ssh-defined-range
  network = "${var.vpc_name}"
  target_tags = ["${var.tag-allow-ssh-defined-range}"]
  source_ranges = var.source_ranges
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  depends_on = [google_compute_network.default]
}

resource "google_compute_firewall" "http-https" {
  name    = var.tag-allow-http-https-all
  network = "${var.vpc_name}"
  target_tags = ["${var.tag-allow-http-https-all}"]
  source_ranges = var.source_ranges
  allow {
    protocol = "tcp"
    ports    = ["80","443"]
  }
  depends_on = [google_compute_network.default]
}