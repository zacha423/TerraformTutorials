terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.63.0"
    }
  }
}

locals {
  token = "${var.prox_token_id}=${var.prox_token_secret}"
}

provider "proxmox" {
  endpoint  = var.prox_endpoint
  api_token = local.token
  insecure  = true
}

data "proxmox_virtual_environment_nodes" "availableNodes" {}