# Setting block
terraform {
    backend "gcs" {
        bucket = "my-terraform-state-bucket"
        prefix = "project1"
        # key    = "path/to/my/terraform.tfstate"
    }
}



