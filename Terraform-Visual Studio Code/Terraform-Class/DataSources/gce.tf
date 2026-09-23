

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
