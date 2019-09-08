variable "project_id" {
  description = "The project ID to host the network in"
}

variable "vpc_name" {
  description = "The name of the VPC network being created"
}

variable "region" {
  description = "The name of the VPC network being created"
}

variable "routing_mode" {
    description = "Sets the network-wide routing mode for Cloud Routers to use. Accepted values are GLOBAL or REGIONAL."
    type        = "string"
    default     = "GLOBAL"
}

# VPC Settings
variable "auto_create_subnetworks" {
    description = "If set to true, this network will be created in auto subnet mode, and Google will create a subnet for each region automatically. If set to false, a custom subnetted network will be created that can support google_compute_subnetwork resources."
    type        = "string"
    default     = "false"
}

variable "subnet" {
    description = "Define subnetwork detail for VPC"
    type        = object({
        name            = string   # name of the subnetwork
        region          = string
        cidr            = string   # The IP address range that machines in this network are assigned to, represented as a CIDR block.
    })
    default     = null
}

variable "enable_flow_logs" {
    description = "Whether to enable flow logging for this subnetwork."
    type        = bool
    default     = false
}

variable "private_ip_google_access" {
    description = "Whether the VMs in this subnet can access Google services without assigned external IP addresses."
    type        = bool
    default     = true
}

variable "source_ranges" {
  type = "list"
  description = "A list of source CIDR ranges that this firewall applies to. Can't be used for EGRESS"
}

variable "tag-allow-ssh-defined-range" {
  type = "string"
  description = "allow-ssh-defined-range"
  default = "allow-ssh-defined-range"
}

variable "tag-allow-http-https-all" {
  type = "string"
  description = "allow-http-https-all"
  default = "allow-http-https-all"
}