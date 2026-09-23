
# Create the Service Account with depends_on to simulate IAM delay

resource "google_service_account" "i27_sa" {
  account_id   = var.service_account_id
  display_name = "Demo SA for VM usage"
  depends_on = [ 
    null_resource.delay_sa_ready
   ]
}

-----------------------------------------------------------------------------------------------------------------------------------

# Simulate Delay

resource "null_resource" "delay_sa_ready" {
  provisioner "local-exec" {
    command = "echo 'Simulating IAM delay...' && sleep 30"
  }
}

------------------------------------------------------------------------------------------------------------------------------------

#Create VM WITHOUT depends_on (Fails Intermittently)

resource "google_compute_instance" "tf_vm_fail" {
  name         = "tf-vm-fail"
  machine_type = "e2-micro"
  zone         = "${var.region}-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network       = "default"
    access_config {}
  }

  service_account {
    email  = "${var.service_account_id}@${var.project_id}.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }

  tags = ["ssh-tag"]
}

# This may fail with an error like:

# Error: The resource 'projects/.../serviceAccounts/...' is not ready

------------------------------------------------------------------------------------------------------------------------------------

# Fix It With depends_on

resource "google_compute_instance" "tf_vm_fixed" {
  name         = "i27-vm-fixed"
  machine_type = "e2-micro"
  zone         = "${var.region}-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network       = "default"
    access_config {}
  }

  service_account {
    email  = "${var.service_account_id}@${var.project_id}.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }

  tags = ["ssh-tag"]

  depends_on = [
    google_service_account.i27_sa,
    null_resource.delay_sa_ready
  ]
}




