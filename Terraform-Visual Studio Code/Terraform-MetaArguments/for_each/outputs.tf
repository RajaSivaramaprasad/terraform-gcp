
# Outputs 

output "subnet_names" {
  value = [for s in google_compute_subnetwork.tf_subnet : s.name]
}

output "vm_names" {
  value = [for vm in google_compute_instance.webserver : vm.name]
}