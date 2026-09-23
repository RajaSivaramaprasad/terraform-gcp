


variable "project" {
  type = string
  default = "my-project-id"
}

variable "region" {
  type = string
  default = "us-central1"
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}


variable "env" {
  description = "Environment name (dev/stage/prod)"
  type = string
  default = "dev"
}
