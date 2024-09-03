terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.63.0"
    }
  }
}

provider "proxmox" {
  # Configuration options
  endpoint = "https://192.168.2.246:8006"
  username = "root@pam"
  password = ""

  insecure = true
}

provider "proxmox" {
  alias    = "zeus"
  endpoint = "https://192.168.2.2:8006"
  username = "root@pam"
  password = ""

  insecure = true
}

resource "proxmox_virtual_environment_vm" "ubuntu_vm" {
  name      = "test-ubuntu"
  node_name = "korman"

  started = false

  initialization {

    ip_config {
      ipv4 {
        address = "192.168.3.233/24"
        gateway = "192.168.3.1"
      }
    }

    user_account {
      username = "ubuntu"
      password = "Passw0rd!"
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
  node_name    = "korman"

  url = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
}

resource "proxmox_virtual_environment_download_file" "debian_cloud_image" {
  content_type = "iso"
  datastore_id = "local"
  node_name    = "korman"

  url                = "https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-genericcloud-amd64.raw"
  file_name          = "debian-12-genericcloud-amd64.img"
  checksum           = "5eebecaf296cb87a9b6431e7147b3cde7556c22d9cbdf3139a85ee212f297b561aea39debe2c1d14d0b4ba71d94b84ca2a904c9dfeb71aa9e04fe18fbe8855f1"
  checksum_algorithm = "sha512"
}

resource "proxmox_virtual_environment_vm" "debianVM" {
  name      = "test-deb"
  node_name = "korman"
  started   = false

  initialization {
    ip_config {
      ipv4 {
        gateway = "192.168.3.1"
        address = "192.168.3.234/24"
      }
    }

    user_account {
      username = "exec"
      password = "Passw0rd!"
    }
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = proxmox_virtual_environment_download_file.debian_cloud_image.id
    interface    = "virtio0"
    file_format = "raw"
    iothread = true
    discard  = "on"
    size     = 32
  }

  network_device {
    bridge = "vmbr0"
  }


}