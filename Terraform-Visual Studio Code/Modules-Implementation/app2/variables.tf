
variable "project_id" {
  description = "GCP Project ID where resources will be created"
  type        = string
  
}

variable "region" {
  description = "GCP Region where resources will be created"
  type        = string

}

# variable "vpc_name" {
 # description = "name of the VPC"
 # type        = string
#}

variable "local_vpc_name" {
  description = "name of the VPC"
  type        = string
}

variable "local_subnet_name" {
  description = "Name of the Subnet"
  type        = string
}

variable "local_subnet_cidr" {
  description = "CIDR range for the subnet"
  type        = string
}

variable "local_vm_name" {
  description = "Name of the VM"
  type        = string
}

variable "local_machine_type" {
  description = "Machine type of the VM"
  type        = string
}

variable "local_zone" {
  description = "Zone where the VM will be created"
  type        = string
}

 variable "subnet_id" {
  description = "ID of the Subnet where the VM will be created"
  type        = string  
   
 }



 
