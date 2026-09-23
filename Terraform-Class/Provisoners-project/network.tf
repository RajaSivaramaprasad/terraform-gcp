
# Create a vpc 
resource "google_compute_network" "tf_vpc" {
  name = var.vpc_name
  auto_create_subnetworks = false
}

# Create Multiple subnets 
resource "google_compute_subnetwork" "tf_subnets" {
    count = length(var.subnets)
  name = var.subnets[count.index].name
  ip_cidr_range = var.subnets[count.index].ip_cidr_range
  region = var.subnets[count.index].subnet_region
  network = google_compute_network.vpc_network.id
}



# Create Firewall Rules
resource "google_compute_firewall" "tf_firewalls" {
  name = var.firewall_name
  network = google_compute_network.vpc_network.name
  allow {
    protocol = "tcp"
    ports = ["80", "443", "8080", "22", "9000"]
  }
  #source_ranges = ["0.0.0.0/0", "32.34.56.23/32"]
 source_ranges = var.source_ranges
}


