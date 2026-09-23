
output "web_server_ips" {
  description = "The External ip addresses of the webserver instances"
  value = [
    for instance in google_compute_instance.web_server_instance :
        instance.network_interface[0].access_config[0].nat_ip
  ]
}