



provider "Google" {
  project = var.project_id
  region = var.region
}


# call a vpc module, written be before
module "vpc" {
  source    = "./Modules/vpc"
  vpc_name  = var.local_vpc_name
}


# call a subnet module, written be before
module "subnet" {
  source       = "./Modules/subnet"
  subnet_name  = var.local_subnet_name
  subnet_cidr  = var.local_subnet_cidr
  region       = var.region
  vpc_id       = module.vpc.vpc_id
  depends_on = [ module.vpc ]
}


# call a gce module, written be before
module "gce" {
  source        = "./Modules/gce"
  vm_name       = var.local_m_name
  machine_type  = var.local_machine_type
  zone          = var.local_zone
  subnet_id     = module.subnet.subnet_id
  depends_on = [ module.subnet ]
} 


