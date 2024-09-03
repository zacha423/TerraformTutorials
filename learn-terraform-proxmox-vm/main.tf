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

resource "proxmox_virtual_environment_download_file" "release_20231228_debian_12_bookworm_qcow2_img" {
  content_type       = "iso"
  datastore_id       = "local"
  file_name          = "debian-12-generic-amd64-20231228-1609.img"
  node_name          = "korman"
  url                = "https://cloud.debian.org/images/cloud/bookworm/20231228-1609/debian-12-generic-amd64-20231228-1609.qcow2"
  checksum           = "d2fbcf11fb28795842e91364d8c7b69f1870db09ff299eb94e4fbbfa510eb78d141e74c1f4bf6dfa0b7e33d0c3b66e6751886feadb4e9916f778bab1776bdf1b"
  checksum_algorithm = "sha512"
}

resource "proxmox_virtual_environment_download_file" "debian_12_genericcloud" {
  content_type = "qcow2"
  datastore_id = "local"
  node_name    = "korman"
  url          = "https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-genericcloud-amd64.qcow2"
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