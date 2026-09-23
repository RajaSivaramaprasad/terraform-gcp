
# Firewall Rule – SSH

resource "google_compute_firewall" "tf_ssh" {
  name    = var.firewall_ssh_name

  allow {
    ports    = ["22"]
    protocol = "tcp"
  }

  direction     = "INGRESS"
  network       = google_compute_network.tf_vpc.id
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["i27-ssh-network-tag"]
}

# Firewall Rule – HTTP

resource "google_compute_firewall" "tf_http" {
  name    = var.firewall_http_name

  allow {
    ports    = ["80"]
    protocol = "tcp"
  }

  direction     = "INGRESS"
  network       = google_compute_network.tf_vpc.id
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["i27-webserver-network-tag"]
}

