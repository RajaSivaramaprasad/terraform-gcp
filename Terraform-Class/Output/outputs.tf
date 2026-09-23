

output "vpc_id" {
  description = "The ID of the VPC"
  value       = google_compute_network.tf_vpc.id
}

output "subnet_id" {
  description = "The ID of the Subnet"
  value       = google_compute_subnetwork.tf_subnet.id
}

output "instance_external_ip" {
  description = "The external IP address of the GCE instance"
  value       = google_compute_instance.tf_gce_vm.network_interface[0].access_config[0].nat_ip
}

output "firewall_rule_names" {
  description = "The names of the firewall rules created"
  value       = [google_compute_firewall.tf_ssh.name, google_compute_firewall.tf_http.name]
}