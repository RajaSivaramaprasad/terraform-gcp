
variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The region where resources will be created"
  type        = string
}


variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "subnet_names" {
  description = "List of subnet names to be created"
  type        = list(string)
}

variable "subnet_cidrs" {
  description = "List of CIDR blocks for the subnets"
  type        = list(string)
}

variable "vm_name" {
  description = "The base name of the VM instances"
  type        = string
}

variable "machine_type" {
  description = "The machine type for the VM instances"
  type        = string
}

variable "instance_count" {
  description = "Number of GCE instances to create"
  type        = number
}

variable "firewall_ssh_name" {
  description = "The name of the SSH firewall rule"
  type        = string
}

variable "firewall_http_name" {
  description = "The name of the HTTP firewall rule"
  type        = string
}

