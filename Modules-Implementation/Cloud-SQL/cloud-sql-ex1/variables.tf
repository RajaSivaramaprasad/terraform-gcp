variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "region" {
  type        = string
  description = "GCP region"
}

variable "environment" {
  type        = string
  description = "Environment key (dev, stage, prod)"
}

variable "instance_configs" {
  description = "Per-env Cloud SQL configs"
  type = map(object({
    name             = string
    vcpus            = number
    memory_mb        = number
    disk_type        = string
    disk_size_gb     = number
    database_version = string
  }))
}

variable "ha_by_env" {
  type        = map(bool)
  description = "Override HA per env"
  default     = {}
}

variable "authorized_networks" {
  description = "Public IP allowlist"
  type = list(object({
    name = string
    cidr = string
  }))
}

variable "database_name" {
  type        = string
  description = "Database to create"
  default     = "appdb"
}

variable "database_user" {
  type        = string
  description = "DB username"
  default     = "appuser"
}

variable "database_password" {
  type        = string
  description = "Optional DB password; if empty, a strong one is generated"
  sensitive   = true
  default     = ""
}

variable "enable_read_replicas" {
  type        = bool
  description = "Create read replicas if true"
  default     = false
}

variable "read_replicas" {
  description = "Replica definitions when enabled"
  type = list(object({
    name   = string
    region = string
  }))
  default = []
}

variable "deletion_protection" {
  type        = bool
  description = "Protect instances from destroy"
  default     = true
}
