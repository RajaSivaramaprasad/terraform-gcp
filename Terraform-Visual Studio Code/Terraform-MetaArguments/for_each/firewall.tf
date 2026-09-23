
#create a firewall rule to allow ssh access

resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = google_compute_network.tf_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh-tag"]
}

# create a firewall rule to allow http access

resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = google_compute_network.tf_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-tag"]
}


