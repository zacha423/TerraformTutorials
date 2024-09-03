# Proxmox Sample Code - Creating a VM using Cloud-init
# Modified from bpg/proxmox
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

resource "proxmox_virtual_environment_vm" "ubuntu_vm" {
  name      = "test-ubuntu"
  node_name = var.cluster_node_1

  initialization {

    ip_config {
      ipv4 {
        address = "192.168.3.233/24"
        gateway = "192.168.3.1"
      }
    }

    user_account {
      username = "ubuntu"
      password = "ubuntu"
    }
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = proxmox_virtual_environment_download_file.ubuntu_cloud_image.id
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = 20
  }

  network_device {
    bridge = "vmbr0"
  }
}

resource "proxmox_virtual_environment_download_file" "ubuntu_cloud_image" {
  content_type = "iso"
  datastore_id = "local"
  node_name    = var.cluster_node_1

  url = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
}