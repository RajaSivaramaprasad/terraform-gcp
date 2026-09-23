
# each.key
# each.value

# create VPC using for_each (Single Resource) 

resource "google_compute_network" "tf_vpc" {
  name                    = "tf-vpc"
  auto_create_subnetworks = false
  description             = "Terraform-managed VPC"
}

# create Subnets using for_each (Map) 

resource "google_compute_subnetwork" "tf_subnet" {
  for_each      = var.subnets
  name          = each.key # or (each.value)  
  ip_cidr_range = each.value.cidr_block
  region        = each.value.region
  network       = google_compute_network.tf_vpc.id
}

