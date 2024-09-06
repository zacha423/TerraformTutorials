# learn-terraform-proxmox-API-token
A sample terraform configuration that connects to the proxmox node using an API token instead of username/password based authentication.

## Required Files
- `main.tf`: The main Terraform configuration file
- `variables.tf`: Terraform variable declarations
- `variables.auto.tfvars`: Variable definitions
- `id_homelab_ed25519.pub`: SSH Key for access into the Proxmox VM.