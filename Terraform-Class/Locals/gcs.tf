
# Google Cloud Storage

resource "google_storage_bucket" "tf_bucket" {
  name = local.bucket_name
  location = local.region
  storage_class = local.storage_class
  project = var.project

  versioning {
    enabled = true
  }
  labels = {
    environment  = var.env
  }
  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 365 
    }
  }
}