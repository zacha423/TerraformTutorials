# Create a multiple cloud-init VMs and reuse the images
terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.63.0"
    }
  }
}

provider "proxmox" {
  # API token preferred over username/password.
  endpoint = var.prox_endpoint
  username = var.prox_username
  password = var.prox_password
  insecure = true
}

resource "proxmox_virtual_environment_vm" "ubuntu_vm_a" {
  name      = "Ubuntu-BPG-1"
  node_name = var.prox_endpoint_name
  started   = true

  initialization {
    ip_config {
      ipv4 {
        address = "192.168.3.233/24"
        gateway = "192.168.3.1"
      }
    }
    user_account {
      username = var.default_account_username
      password = var.default_account_password
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

resource "proxmox_virtual_environment_vm" "debian_vm_a" {
  name      = "Debian-1"
  node_name = var.prox_endpoint_name
  started   = true

  initialization {
    ip_config {
      ipv4 {
        gateway = "192.168.3.1"
        address = "192.168.3.234/24"
      }
    }
    user_account {
      username = var.default_account_username
      password = var.default_account_password
    }
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = proxmox_virtual_environment_download_file.debian_cloud_image.id
    interface    = "virtio0"
    file_format  = "raw"
    iothread     = true
    discard      = "on"
    size         = 32
  }

  network_device {
    bridge = "vmbr0"
  }
}

resource "proxmox_virtual_environment_vm" "ubuntu_vm_b" {
  name      = "Ubuntu-BPG-2"
  node_name = var.prox_endpoint_name
  started   = true

  initialization {
    ip_config {
      ipv4 {
        address = "192.168.3.235/24"
        gateway = "192.168.3.1"
      }
    }
    user_account {
      username = var.default_account_username
      password = var.default_account_password
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

resource "proxmox_virtual_environment_vm" "debian_vm_b" {
  name      = "Debian-2"
  node_name = var.prox_endpoint_name
  started   = true

  initialization {
    ip_config {
      ipv4 {
        gateway = "192.168.3.1"
        address = "192.168.3.236/24"
      }
    }
    user_account {
      username = var.default_account_username
      password = var.default_account_password
    }
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = proxmox_virtual_environment_download_file.debian_cloud_image.id
    interface    = "virtio0"
    file_format  = "raw"
    iothread     = true
    discard      = "on"
    size         = 32
  }

  network_device {
    bridge = "vmbr0"
  }
}