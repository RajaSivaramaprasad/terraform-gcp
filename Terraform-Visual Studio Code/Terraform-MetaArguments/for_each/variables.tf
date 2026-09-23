
variable "project_id" {
  type    = string
  default = "my-project1-id"
}

variable "region" {
  type    = string
  default = "us-central1"
}



# Subnets using for_each (Map)

#Subnet Variable

variable "subnets" {
  type = map(object({
    cidr_block = string
    region     = string
  }))
  default = {
     # "key"             = { value }
    "us-central1-subnet" = { cidr_block = "10.10.0.0/16", region = "us-central1" }
    "us-east1-subnet"    = { cidr_block = "10.20.0.0/16", region = "us-east1" }
  }
}

# vm using for_each (List)

# VM Variable

variable "vm_names" {
  type    = list(string)
  default = ["tf-vm-1", "tf-vm-2"]
}


