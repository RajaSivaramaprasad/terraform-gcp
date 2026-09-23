
project_id         = "my-project1-id"
region             = "us-central1"
vpc_name           = "tf-vpc"

subnet_names       = ["tf-subnet-1", "tf-subnet-2", "tf-subnet-3"]
subnet_cidrs       = ["10.2.0.0./16","10.4.0.0/16", "10.6.0.0/16"]

vm_name            = "tf-webserver"
machine_type       = "e2-micro"
instance_count     = 2

firewall_ssh_name  = "tf-allow-ssh-22"
firewall_http_name = "tf-allow-http-80"


