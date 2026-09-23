
#Create a VPC

resource "google_compute_network" "tf_vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
  description             = "Creating a VPC from terraform"
}


#Create Multiple Subnets using count

resource "google_compute_subnetwork" "tf_subnet" {
  count         = length(var.subnet_names)
  name          = var.subnet_names[count.index]
  region        = var.region
  ip_cidr_range = var.subnet_cidrs[count.index]
  network       = google_compute_network.tf_vpc.id
}




