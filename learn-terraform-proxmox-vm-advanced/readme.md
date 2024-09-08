# learn-terraform-proxmox-vm-advanced
A sample terraform configuration that builds a pair of Ubuntu VMs and Debian VMs using a basic cloud init configuration password based authentication for the user accounts.

## Required Files
- `main.tf`: The main Terraform configuration file
- `variables.tf`: Terraform variable declarations
- `variables.auto.tfvars`: Variable definitions
- `cloudImages.tf`: An additional file used to hold data related to the VM images.