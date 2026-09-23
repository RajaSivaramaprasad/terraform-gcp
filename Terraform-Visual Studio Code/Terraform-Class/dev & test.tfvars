
# Using dev.tfvars and test.tfvars for Environments

#dev.tfvars

project_id    = "my-project-id"
region        = "us-central1"
zone          = "us-central1-a"
machine_type  = "e2-micro"



#test.tfvars

project_id    = "my-project-id"
region        = "us-east1"
zone          = "us-east1-b"
machine_type  = "e2-small"



# Apply for dev environment
terraform apply -var-file="dev.tfvars"

# Apply for test environment
terraform apply -var-file="test.tfvars"



----------------------------------------------------------------------------------------------------

# Run Time Examples: "-var-file" is Higher Priority than terraform.tfvars

#Source	                   # Priority

CLI (-var)  	            Highest
.tfvars file	            Medium
Environment variable	    Medium
default in code	            Lowest




