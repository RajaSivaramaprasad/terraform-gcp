


provider "google" {
  project = var.project_id
  region  = var.region
}

-----------------------------------------------------

variable "region" {
  type    = string
  default = "us-central1"
}


variable "project_id" {
  type    = string
  default = "my-project-id"
}

-----------------------------------------------------


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

-----------------------------------------------------

data "google_compute_zones" "available_zones" {
  region = var.region
  # list all zones in specified region
  # "us-central1-a", "us-central1-b", "us-central1-c", "us-central1-f"

}

-----------------------------------------------------

resource "google_compute_instance" "web_instance" {
    count       = 2 
  name         = "web-instance-${count.index}"
  machine_type = "e2-micro"
  zone         = data.google_compute_zones.available_zones.names[count.index]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    
    subnetwork = google_compute_subnetwork.tf_subnet.id
    # network = "default"
    
    access_config {
      // Ephemeral public IP
    }
  }
 
}

-----------------------------------------------------

output "web_server_ips" {
  description = "The External ip addresses of the webserver instances"
  value = [
    for instance in google_compute_instance.web_server_instance :
        instance.network_interface[0].access_config[0].nat_ip
  ]
}