# Proxmox Sample Code
terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.63.0"
    }
  }
}

provider "proxmox" {
  # API Token prefferred over username/password.
  endpoint = var.proxmox_endpoint
  username = var.proxmox_username
  password = var.proxmox_password
  insecure = true #Self-signed cert

  ssh {
    agent = true
  }
}

resource "proxmox_virtual_environment_vm" "sampleVM" {
  name        = "terraformVM"
  description = "managed through terraform"

  node_name = var.cluster_node_1
  vm_id     = 4321

  memory {
    dedicated = 2048
  }

  disk {
    datastore_id = "local-lvm"
    interface    = "scsi0"
    size         = 32
    file_format  = "raw"
  }

  cdrom {
    enabled = true
    file_id = "local:iso/debian-12.1.0-amd64-netinst.iso"
  }

  network_device {
    bridge = "vmbr0"
  }

  operating_system {
    type = "l26"
  }

  # Requires cloud-init
  # initialization {
  #   ip_config {
  #     ipv4 {
  #       address = "dhcp"
  #     }
  #   }

  #   user_account {
  #     password = "Abc123!"
  #     username = "myAccountTest"
  #   }
  # }
}