#terraform {
 # required_version = "~> 1.13.0"

  #required_providers {
   # google = {
    #  source  = "hashicorp/google"
     # version = "~> 7.4.0"
    #}
  #}


  
provider "google" {
  project = var.project
  region = var.region
}


variable "project" {
  type = string
  default = "my-project-id"
}


variable "region" {
  type = string
  default = "us-central1"
}

# vpc
resource "google_compute_network" "tf_vpc" {
name = "tf-state-vpc"
auto_create_subnetworks = false
}

#subnet
resource "google_compute_subnetwork" "tf_subnet" {
    name = "tf-state-subnet"
    ip_cidr_range = "10.10.0.0/24"
    region = var.region
    network = google_compute_network.tf_vpc.id
      
}

#firewall
resource "google_compute_firewall" "allow_ssh" {
    name = "tf-allow-ssh"
    network = google_compute_network.tf_vpc.name

    allow {
      protocol = "tcp"
      ports = [ "22" ]

    }
  source_ranges = [ "0.0.0.0/0" ]
}

 #GCE
resource "google_compute_instance" "vm_instance" {
    name = "tf-vm-instance"
    machine_type = "e2-micro"
    zone = "us-central1-a"

boot_disk {
  initialize_params {
    image = "debian-cloud/debian-12"
  }
}  

network_interface {
  subnetwork = google_compute_subnetwork.tf_subnet.id
    access_config {
          }
}
tags = [ "allow-ssh" ]

}




#outputs

output "vpc_name" {
    description = "The name of the VPC"
value = google_compute_network.tf_vpc.name  
}

output "subnet_name" {
    description = "The name of the Subnet"
value = google_compute_subnetwork.tf_subnet.name   
}

output "firewall_name" {
    description = "The name of the Firewall"
  value = google_compute_firewall.allow_ssh.name
}

output "instance_name" {
    description = "The name of the VM Instance"
  value = google_compute_instance.vm_instance.name
}


+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# State, Drift, Refresh, taint/untaint, import, -target, workspaces

# terraform refresh
# terraform state list
# terraform state show
# terraform state rm
# terraform import
# terraform destroy -target=select resource list
# terraform apply -target=select resource list
# terraform workspace list --> default
# terraform workspace new dev/prod/test etc...
# terraform workspace select default
        # terraform destroy -var-file="dev.tfvars" --auto-approve





