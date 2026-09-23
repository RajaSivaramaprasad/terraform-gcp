
# Workflow: init--->validate--->plan--->apply--->destroy

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

1.Provider Block
2.Resource Block
3.settings Block or terraform Block
4.data source Block
5.Output Block

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# provider

provider "google" {
    #  arguments
  project     = "my-project-id"
  region      = "us-central1" 
 # credentials = file("key.json")
}
-------------------------------------------------------------------------------------

provider "google" {
  project = var.project_id
  region  = var.region
}

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

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
    #network    = google_compute_network.tf_vpc.id
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
--------------------------------------------------------------------

resource "google_compute_network" "tf_vpc" {
  name                    = var.vpc_name
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
------------------------------------------------------------------

# variable type: "string"

resource "google_compute_subnetwork" "tf_subnet" {
  name          = var.subnet_name
  region        = var.region
  ip_cidr_range = var.subnet_cidr
  network       = google_compute_network.tf_vpc.id
}

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# create a firewall

# name, network, allow, direction, priority, source_ranges, target_tags
resource "google_compute_firewall" "tf_firewall" {
  name    = "my-firewall"
  network = google_compute_network.tf_vpc.id

  allow {
    protocol = "tcp"
    ports    = ["8080", "443"]
  }
  direction = "INGRESS"
  priority = 1000

  source_ranges = ["0.0.0.0/0"]
# (optional) you can add target tags to apply firewall rules to specific instances
target_tags = [ "ssh-network-tag", "http-network-tag", "https-network-tag"]

}

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# variable type: "number"

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

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# variable type: "boolean"

# create a vm with conditional startup script

resource "google_compute_instance" "tf_gce_vm" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone
  tags         = var.vm_tags
}

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.tf_subnet.id
    access_config {}
  }
 metadata_startup_script = var.enable_startup_script ? file("${path.module}/startup.sh") : null

  
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# variable type: "list of string"

# create a vm

resource "google_compute_instance" "tf_gce_vm" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone
  tags         = var.vm_tags
}
-----------------------------------------------------------------------------
# variable type: "map of string"

# create a vm based on environment

resource "google_compute_instance" "tf_gce_vm" {
  name         = "my-${var.environment}-vm"
  machine_type = var.machine_types[var.environment]
  zone         = var.zone

}
---------------------------------------------------------------------------------
# variable type: "object"

resource "google_compute_instance" "tf_gce_vm" {
  name         = var.vm_config.name
  machine_type = var.vm_config.machine_type
  zone         = var.vm_config.zone
  tags         = var.vm_config.tags
}


  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.tf_subnet.id
    access_config {}
  }

  tags = ["ssh-network-tag", "webserver-network-tag"]

---------------------------------------------------------------------------------------
# variable type: "list of objects"

# create a VM1 instance

resource "google_compute_instance" "vm1" {
  name         = var.vm_list[0].name
  machine_type = var.vm_list[0].machine_type
  zone         = var.vm_list[0].zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.tf_subnet.id
    access_config {}
  }

  tags = var.vm_list[0].tags
}


# create a VM2 instance

resource "google_compute_instance" "vm2" {
  name         = var.vm_list[1].name
  machine_type = var.vm_list[1].machine_type
  zone         = var.vm_list[1].zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.tf_subnet.id
    access_config {}
  }

  tags = var.vm_list[1].tags
}

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# variable type: "Sensitive"

# create a Cloud SQL instance

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_sql_database_instance" "tf_sql_instance" {
  name             = var.db_instance_name
  database_version = "MYSQL_8_0"
  region           = var.region

  settings {
    tier = "db-f1-micro"

    ip_configuration {
      ipv4_enabled = true
      authorized_networks {
        name  = "allow-public"
        value = "0.0.0.0/0"
      }
    }
  }

  deletion_protection = false
}

resource "google_sql_user" "tf_db_user" {
  name     = var.db_user
  instance = google_sql_database_instance.tf_sql_instance.name
  password = var.db_password
}

output "db_password_plain_test" {
  value     = var.db_password
  sensitive = true
}

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

