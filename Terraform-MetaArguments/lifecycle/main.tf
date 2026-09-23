

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
  description             = "Terraform-managed VPC"
}

-----------------------------------------------------

resource "google_compute_subnetwork" "tf_subnet" {
  for_each      = var.subnets
  name          = "my-subnet"
  ip_cidr_range = "10.0.0.0/24"
  region        = var.region
  network       = google_compute_network.tf_vpc.id
}

-----------------------------------------------------


resource "google_compute_instance" "tf_instance" {
  name         = "my-tf-instance"
  machine_type = "e2-micro"
  zone         = "${var.region}-a"

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
 metadata = {
    startup-script = "echo 'Hello, Terraform!' > /tmp/hello.txt" 
    }


    lifecycle {
       #1. create_before_destroy = true
        
       #2.  prevent_destroy = true
       
       #3.  ignore_changes = [
            #     metadata
            #    etc........
        #]
    }

}

-----------------------------------------------------
