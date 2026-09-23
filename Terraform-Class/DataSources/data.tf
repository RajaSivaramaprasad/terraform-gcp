

data "google_compute_zones" "available_zones" {
  region = var.region
  # list all zones in specified region
  # "us-central1-a", "us-central1-b", "us-central1-c", "us-central1-f"

}
