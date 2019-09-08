output "tag-allow-ssh-defined-range" {
  value = var.tag-allow-ssh-defined-range
}

output "tag-allow-http-https-all" {
  value = var.tag-allow-http-https-all
}

output "subnet_name" {
  value = "${google_compute_subnetwork.default.name}"
}