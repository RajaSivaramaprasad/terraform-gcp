
# For loop to get all vm names in a list 

output "all_vm_names_list" {
  description = "List of all the VM names"
  value = [for instance in google_compute_instance.tf_gce_vm : instance.name]
}

# For loop to create a map of VM names and there ids

# {for item in list : key => value}

output "vm_name_to_id" {
  value = {
    for instance in google_compute_instance.tf_gce_vm : instance.name => instance.id
  }
}


# Output a complex map of instance details

output "instance_details" {
  description = "A complex map of details for each GCE instance"
  value = {
    for instance in google_compute_instance.tf_gce_vm : instance.name => {
        id = instance.id 
        machine_type = instance.machine_type
        zone = instance.zone
        external_ip = instance.network_interface[0].access_config[0].nat_ip # attributes 
    }
  }
}


