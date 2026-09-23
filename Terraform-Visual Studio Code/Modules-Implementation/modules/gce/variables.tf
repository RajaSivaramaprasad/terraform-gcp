
variable "vm_name" {
  description = "Name of the VM"
type = string
}

variable "machine_type" {
  description = "Machine type of the VM"
type = string
}

variable "zone" {
  description = "Zone where the VM will be created" 
type = string
}

variable "subnet_id" {
  description = "ID of the Subnet wher the VM will be created"
type = string
}



