
# Google Compute Instance

resource "google_compute_instance" "tf_gce_vm" {
  name = local.instance_name
  machine_type = local.machine_type
  zone = "${var.region}-a"
  boot_disk {
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-minimal-2204-jammy-v20250424"
    }
  }
  network_interface {
    #
    subnetwork = "default"
    access_config {
      
    }
  }

  tags = local.tags
}

