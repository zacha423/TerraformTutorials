# Creating a VM with a custom cloud-init configuration
# Modified from BPG/Proxmox example code
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

data "local_file" "ssh_public_key" {
  filename = "./id_homelab_ed25519.pub"
}

resource "proxmox_virtual_environment_file" "cloud_config_ssh" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.prox_endpoint_name

  source_raw {
    data = <<-EOF
    #cloud-config
    users:
      - default
      - name: ubuntu
        groups:
          - sudo
        shell: /bin/bash
        ssh_authorized_keys:
          - ${trimspace(data.local_file.ssh_public_key.content)}
        sudo: ALL=(ALL) NOPASSWD:ALL
    runcmd:
        - apt update
        - apt install -y qemu-guest-agent net-tools
        - timedatectl set-timezone America/Toronto
        - systemctl enable qemu-guest-agent
        - systemctl start qemu-guest-agent
        - echo "done" > /tmp/cloud-config.done
    EOF

    file_name = "cloud-config_ssh.yaml"
  }
}

resource "proxmox_virtual_environment_vm" "ubuntu_vm" {
  name      = "test-ubuntu"
  node_name = var.prox_endpoint_name

  agent {
    enabled = true
  }

  cpu {
    cores = 2
  }

  memory {
    dedicated = 2048
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = proxmox_virtual_environment_download_file.ubuntu_cloud_image.id
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = 20
  }

  initialization {
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.cloud_config_ssh.id
  }

  network_device {
    bridge = "vmbr0"
  }
}

resource "proxmox_virtual_environment_download_file" "ubuntu_cloud_image" {
  content_type = "iso"
  datastore_id = "local"
  node_name    = var.prox_endpoint_name

  url = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
}

output "vm_ipv4_address" {
  value = proxmox_virtual_environment_vm.ubuntu_vm.ipv4_addresses[1][0]
}