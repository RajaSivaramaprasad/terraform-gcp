
# GCE VMs using for_each (List)


resource "google_compute_instance" "webserver" {
  for_each     = toset(var.vm_names)
  name         = each.key # or (each.value)  
  machine_type = "e2-micro"
  zone         = "${var.region}-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    subnetwork    = google_compute_subnetwork.tf_subnet["us-central1-subnet"].id
    access_config {}
  }

  metadata_startup_script = file("${path.module}/startup.sh")
  tags = ["ssh-tag", "http-tag"]
}