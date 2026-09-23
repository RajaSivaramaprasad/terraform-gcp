

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
