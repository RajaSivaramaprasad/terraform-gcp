
# provider

provider "google" {
    #  arguments
  project     = "my-project-id"
  region      = "us-central1"
 # credentials = file("key.json")
}


# create a vm instance
# name, machine_type, zone, boot_disk, network_interface, tags, metadata_startup_script, access_config

resource "google_compute_instance" "tf_instance" {
  name         = "my-tf-instance"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network    = google_compute_network.tf_vpc.id
    subnetwork = google_compute_subnetwork.tf_subnet.id
    # network = "default"
    
    access_config {
      // Ephemeral public IP
    }
  }

 metadata_startup_script = file("${path.module}/startup.sh")

  # optional
  tags = ["ssh-network-tag", "http-network-tag", "https-network-tag"]

---------------------------(or)----------------------------------------

#tolist(google_compute_firewall.tf_firewall.target_tags)[0]
#tolist(google_compute_firewall.tf_firewall.target_tags)[1]
#tolist(google_compute_firewall.tf_firewall.target_tags)[2]
 
 
}
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


# create a vpc network
# name, auto_create_subnetworks

resource "google_compute_network" "tf_vpc" {
  # key   = "value"
  name  = "my-vpc"
  auto_create_subnetworks = false
}


++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# create a subnet
# name, ip_cidr_range, region, network

resource "google_compute_subnetwork" "tf_subnet" {
name = "my-subnet"
ip_cidr_range = "10.6.0.0/16"
region = "us-central1"
    # implict dependency
network = google_compute_network.tf_vpc.id
}


++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

 # create a firewall-1

resource "google_compute_firewall" "tf_ssh" {
  name          = "allow-ssh"
  network       = google_compute_network.tf_vpc.id
  direction     = "INGRESS"
  #priority      = 1000
  priority      = var.ssh_priority
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags = ["ssh-network-tag"]
}

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# create a firewall-2

resource "google_compute_firewall" "tf_http" {
  name          = "allow-http"
  network       = google_compute_network.tf_vpc.id
  direction     = "INGRESS"
  #priority      = 1000
  priority      = var.http_priority
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  target_tags = ["webserver-network-tag"]
}


