

resource "google_compute_network" "tf_vpc" {
  name                    = "my-vpc"
  auto_create_subnetworks = false
  description             = "data-managed VPC"
}

-----------------------------------------------------

resource "google_compute_subnetwork" "tf_subnet" {
  name          = "my-subnet"
  ip_cidr_range = "10.0.0.0/24"
  region        = var.region
  network       = google_compute_network.tf_vpc.id
}


