# learn-terraform-proxmox-cloudinit-advanced
A sample terraform configuration that builds an Ubuntu VM using a custom cloud init configuration and SSH key access to the VM.

## Required Files
- `main.tf`: The main Terraform configuration file
- `variables.tf`: Terraform variable declarations
- `variables.auto.tfvars`: Variable definitions
- `id_homelab_ed25519.pub`: SSH Key for access into the Proxmox VM.