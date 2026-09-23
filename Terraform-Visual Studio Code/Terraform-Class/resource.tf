# resource block 
#-------------------- 
# syntax: resource "<PROVIDER>_<RESOURCE_TYPE>" "<LOCAL_NAME>" {
  # Configuration arguments
#}
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#create a vm instance
#name, machine_type, zone, boot_disk, network_interface, tags, metadata_startup_script, access_config

#resource "google_compute_instance" "tf_instance" {
  #name         = "my-tf-instance"
  #machine_type = "e2-micro"
  #zone         = "us-central1-a"

  #boot_disk {
    #initialize_params {
    #  image = "debian-cloud/debian-11"
   # }
  #}

  #network_interface {
    #network    = google_compute_network.tf_vpc.id
    #subnetwork = google_compute_subnetwork.tf_subnet.id

    #access_config {
    #  // Ephemeral public IP
   # }
  #}

  #tags = ["ssh-network-tag", "http-network-tag", "https-network-tag"]
#===========(or)===========
#tolist(google_compute_firewall.tf_firewall.target_tags)[0]
#tolist(google_compute_firewall.tf_firewall.target_tags)[1]
#tolist(google_compute_firewall.tf_firewall.target_tags)[2]
  
#allow_stopping_for_update = true

#metadata_startup_script = file("${path.module}/startup.sh")


#}


#create a vpc network
#name, auto_create_subnetworks

#resource "google_compute_network" "tf_vpc" {
  #key   = "value"
 # name  = "my-vpc"
 # auto_create_subnetworks = false
#}


#create a subnet
#name, ip_cidr_range, region, network

#resource "google_compute_subnetwork" "tf_subnet" {
  #key   = "value"
#name = "my-subnet"
#ip_cidr_range = "10.6.0.0/16"
#region = "us-central1"
    #implict dependency
#network = google_compute_network.tf_vpc.id
#}



#firewall
#name, network, allow, source_ranges, direction, priority, target_tags
#resource "google_compute_firewall" "tf_firewall" {
 # name    = "my-firewall"
 # network = google_compute_network.tf_vpc.id

  #allow {
   # protocol = "tcp"
    #ports    = ["22", "80", "443"]
  #}
  #direction = "INGRESS"
  #priority = 1000

  #source_ranges = ["0.0.0.0/0"]

#(optional) you can add target tags to apply firewall rules to specific instances
#target_tags = [ "ssh-network-tag", "http-network-tag", "https-network-tag"]

#}





