#Using terraform.tfvars to Avoid Prompts


project_id    = "my-project-id"
region        = "us-central1"
zone          = "us-central1-a"
machine_type  = "e2-micro"



============================== Input Variables ======================================================


-------------------------------------------------------------------------------------

# Variable Type: "string"

project_id     = "my-project-id"
region         = "us-central1"
zone           = "us-central1-a"
vm_name        = "custom-vm-name"
machine_type   = "e2-medium"

----------------------------------------------------------------------------------------

# Variable Type: "number"

project_id     = "my-project-id"
ssh_priority   = 800
http_priority  = 900
region         = "us-central1"
zone           = "us-central1-a"
vm_name        = "custom-vm-name"
machine_type   = "e2-medium"

--------------------------------------------------------------------------------------

# variable Type: "boolean"

project_id            = "my-project-id"
enable_startup_script = true
ssh_priority          = 800
http_priority         = 900
region                = "us-central1"
zone                  = "us-central1-a"
vm_name               = "custom-vm-name"
machine_type          = "e2-medium"

------------------------------------------------------------------------------------------

# Variable Type: "list of strings"

project_id = "my-project-id"
vm_tags    = ["ssh-network-tag", "webserver-network-tag", "https-server"]

---------------------------------------------------------------------------------------------------
# Variable Type: "map of strings"

project_id   = "my-project-id"
environment  = "stage"

---------------------------------------------------------------------------------------------------------------

# Variable Type: "object"

project_id = "my-project-id"

vm_config = {
  name         = "stage-vm"
  machine_type = "e2-small"
  zone         = "us-central1-b"
  tags         = ["ssh-network-tag", "webserver-network-tag", "https-server"]
}

------------------------------------------------------------------------------------------------------------------

# Variable Type: "List of objects"

project_id = "my-project-id"

vm_list = [
  {
    name         = "vm-1"
    machine_type = "e2-micro"
    zone         = "us-central1-a"
    tags         = ["ssh", "web"]
  },
  {
    name         = "vm-2"
    machine_type = "e2-small"
    zone         = "us-central1-b"
    tags         = ["ssh"]
  }
]


------------------------------------------------------------------------------------------------------------

# Variable Type: "sensitive"

project_id  = "my-project-id"
db_password = "******"

---------------------------------------------------------------------------------------------

# Variable Type: "Validation"


---------------------------------------------------------------------------------------------