#Terraform Input Variables – Default Values

variable "machine_type" {
  type        = string
  description = "The machine type for the VM instance"
  default     = "e2-micro"
}

variable "project_id" {
  type        = string
  description = "The GCP project ID"
  default     = "my-project-id"
}
variable "region" {
  type        = string
  description = "The GCP region"
  default     = "us-central1"
}

variable "zone" {
  type        = string
  description = "The GCP zone"
  default     = "us-central1-a"
}




================================== Input Variables ============================================

# Variable Type: "string"

variable "project_id" {
  type        = string
  default     = "my-project-id"
}

variable "region" {
  type        = string
  default     = "us-central1"
}

variable "zone" {
  type        = string
  default     = "us-central1-a"
}

variable "vpc_name" {
  type        = string
  default     = "tf_vpc"
}

variable "subnet_name" {
  type        = string
  default     = "tf_subnet"
}

variable "subnet_cidr" {
  type        = string
  default     = "10.6.0.0/16"
}

variable "vm_name" {
  type        = string
  default     = "tf_webserver"
}

variable "machine_type" {
  type        = string
  default     = "e2-micro"
}

variable "db_instance_name" {
  type        = string
  default     = "db-instance"
}

variable "db_user" {
  type        = string
  default     = "admin"
}

variable "db_password" {
  type        = string
  description = "Database user password (kept sensitive)"
  sensitive   = true
}

-------------------------------------------------------------
# Variable Type: "number"

variable "ssh_priority" {
  type        = number
  description = "Priority for SSH firewall rule"
  default     = 1000
}

variable "http_priority" {
  type        = number
  description = "Priority for HTTP firewall rule"
  default     = 1000
}

--------------------------------------------------------------------------
# variable Type: "boolean"

variable "enable_startup_script" {
  type        = bool
  description = "Whether to enable the startup script"
  default     = false
}

-------------------------------------------------------------------------------------
# Variable Type: "list of strings"

variable "vm_tags" {
  type        = list(string)
  description = "Network tags for the GCE instance"
  default     = ["ssh-network-tag", "webserver-network-tag"]
}

-------------------------------------------------------------------------------------

# Variable Type: "map of strings"

variable "machine_types" {
  type = map(string)
  default = {
    dev   = "e2-micro"
    stage = "e2-small"
    prod  = "e2-medium"
  }
}

------------------------------------------------------------------------------------------

# Variable Type: "object"

variable "vm_config" {
  type = object({
    name         = string
    machine_type = string
    zone         = string
    tags         = list(string)
  })

  default = {
    name         = "webserver"
    machine_type = "e2-micro"
    zone         = "us-central1-a"
    tags         = ["ssh-network-tag", "webserver-network-tag"]
  }
}


--------------------------------------------------------------------------------------

# Variable Type: "list of objects"

variable "vm_list" {
  description = "List of VMs to create"
  type = list(object({
    name         = string
    machine_type = string
    zone         = string
    tags         = list(string)
  }))
}

---------------------------------------------------------------------------------------------

# Variable Type: "sensitive"

variable "db_password" {
  type        = string
  description = "Database user password (kept sensitive)"
  sensitive   = true
}

------------------------------------------------------------------------------------------

variable "environment" {
  type        = string
  description = "Deployment environment"
  default     = "dev"


--------------------------------------------------------------------------------------
# Variable Type: "Validation"

validation {
    condition     = contains(["dev", "stage", "prod"], var.environment)
    error_message = "Environment must be one of 'dev', 'stage', or 'prod'."
  }
}
-----------------------------------------------------------------------------------













