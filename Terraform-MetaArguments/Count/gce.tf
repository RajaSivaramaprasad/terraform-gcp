
#Create Multiple GCE Instances using count

resource "google_compute_instance" "tf_gce_vm" {
  count        = var.instance_count
  name         = "${var.vm_name}-${count.index}"
  #name         = "${var.vm_name}-${count.index + 1}"
  machine_type = var.machine_type
  zone         = "${var.region}-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    subnetwork    = google_compute_subnetwork.tf_subnet[count.index].id
    access_config {}
  }

  
  # metadata_startup_script = file("${path.module}/startup.sh")

  # tags = [
    # tolist(google_compute_firewall.tf_http.target_tags)[0],
    # tolist(google_compute_firewall.tf_ssh.target_tags)[0]
  #]

}



