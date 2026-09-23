
output "instance_ips" {
    value = {
        for instance in googoogle_compute_instance.tf-vm-instance :
        instance.name => {
            public_ip = instance.network_interface[0].access_config[0].nat_ip
            private_ip = instance.network_interface[0].neework_ip 
        }
    }
 
}


output "ansible_ssh_command" {
 value = "To connect ansible vm, use this command: ssh-i id_rsa ${var.vm_user}@${google_compute_instance.tf-vm-instance["ansible"].network_interface[0].access_config[0].nat_ip}"

}

output "jenkins_master_ssh_command" {
 value = "To connect jenkins-master vm, use this command: ssh-i id_rsa ${var.vm_user}@${google_compute_instance.tf-vm-instance["jenkins-master"].network_interface[0].access_config[0].nat_ip}"
  
}

