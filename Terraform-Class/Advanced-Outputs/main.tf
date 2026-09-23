

 # ************************************************************************** Advanced **********************************************
 # Provider Block 
provider "google" { 
  region = "us-central"
  project = "silver-tempo-455118-a5"
}


# VPC:
resource "google_compute_network" "tf_vpc" {
  name = "i27-for-vpc"
  auto_create_subnetworks = false
}

# create a subnet 
resource "google_compute_subnetwork" "tf_subnet" {
  name = "i27-for-subnet"
  region = "us-central1"
  ip_cidr_range = "10.4.0.0/16"
  network = google_compute_network.tf_vpc.id
}


variable "vm_name" {
  type = string
  default = "i27-webserver"
}

variable "machine_type" {
  type = string 
  default = "e2-medium"
}

variable "instance_count" {
  type = number
  default = 2
}
resource "google_compute_instance" "tf_gce_vm" {
  count = var.instance_count
  name = "${var.vm_name}-${count.index}"
  machine_type = var.machine_type
  zone = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/debian-12-bookworm-v20250415"
    }
  }
  network_interface {
    subnetwork = "default "
    access_config {
      // ephemeral ip
    }
  }
}