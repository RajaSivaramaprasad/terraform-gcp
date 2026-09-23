terraform {
  required_version = ">= 1.5.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.30.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6.0"
    }
  }
}

locals {
  # Pick current env config object (from tfvars map)
  cfg = var.instance_configs[var.environment]

  # Custom machine tier string
  tier = format("db-custom-%d-%d", local.cfg.vcpus, local.cfg.memory_mb)

  # HA defaults (stage/prod => true) with override support via ha_by_env
  ha_enabled = coalesce(
    try(var.ha_by_env[var.environment], null),
    (var.environment == "stage" || var.environment == "prod")
  )
  availability_type = local.ha_enabled ? "REGIONAL" : "ZONAL"
}

# Primary Cloud SQL instance
resource "google_sql_database_instance" "primary" {
  project             = var.project_id
  name                = local.cfg.name
  region              = var.region
  database_version    = local.cfg.database_version
  deletion_protection = var.deletion_protection

  settings {
    tier              = local.tier
    disk_type         = local.cfg.disk_type
    disk_size         = local.cfg.disk_size_gb
    availability_type = local.availability_type
    activation_policy = "ALWAYS"

    backup_configuration { enabled = true }

    ip_configuration {
      ipv4_enabled = true

      # authorized_networks must be blocks; emit from list via dynamic
      dynamic "authorized_networks" {
        for_each = var.authorized_networks
        content {
          name  = authorized_networks.value.name
          value = authorized_networks.value.cidr
        }
      }
    }
  }

  # Guardrails
  lifecycle {
    precondition {
      condition     = local.cfg.memory_mb % 256 == 0
      error_message = "Cloud SQL memory must be a multiple of 256 MB. Got: ${local.cfg.memory_mb}"
    }
    precondition {
      condition     = local.cfg.vcpus > 0
      error_message = "vCPUs must be > 0. Got: ${local.cfg.vcpus}"
    }
    precondition {
      condition     = local.cfg.disk_size_gb > 20
      error_message = "Disk size must be > 20 GB. Got: ${local.cfg.disk_size_gb}"
    }
  }
}

# Logical database
resource "google_sql_database" "db" {
  project  = var.project_id
  instance = google_sql_database_instance.primary.name
  name     = var.database_name
}

# Password generator (used if user doesn't supply one)
resource "random_password" "db_user_password" {
  length           = 20
  special          = true
  min_special      = 2
  override_special = "!@#%^*-_=+"
}

# DB user (uses provided password or generated one)
resource "google_sql_user" "db_user" {
  project  = var.project_id
  instance = google_sql_database_instance.primary.name
  name     = var.database_user
  password = var.database_password != "" ? var.database_password : random_password.db_user_password.result
}

# Optional read replicas
resource "google_sql_database_instance" "replicas" {
  for_each = var.enable_read_replicas ? {
    for r in var.read_replicas : r.name => r
  } : {}

  project              = var.project_id
  name                 = each.value.name
  region               = each.value.region
  database_version     = local.cfg.database_version
  master_instance_name = google_sql_database_instance.primary.name

  settings {
    tier      = local.tier
    disk_type = local.cfg.disk_type
    disk_size = local.cfg.disk_size_gb

    ip_configuration {
      ipv4_enabled = true

      dynamic "authorized_networks" {
        for_each = var.authorized_networks
        content {
          name  = authorized_networks.value.name
          value = authorized_networks.value.cidr
        }
      }
    }
  }

  deletion_protection = var.deletion_protection

  lifecycle {
    precondition {
      condition     = local.cfg.memory_mb % 256 == 0
      error_message = "Replica memory must be a multiple of 256 MB. Got: ${local.cfg.memory_mb}"
    }
    precondition {
      condition     = local.cfg.vcpus > 0
      error_message = "Replica vCPUs must be > 0. Got: ${local.cfg.vcpus}"
    }
    precondition {
      condition     = local.cfg.disk_size_gb > 0
      error_message = "Replica disk size must be > 0 GB. Got: ${local.cfg.disk_size_gb}"
    }
  }
}
