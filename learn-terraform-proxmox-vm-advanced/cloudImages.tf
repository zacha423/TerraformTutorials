resource "proxmox_virtual_environment_download_file" "ubuntu_cloud_image" {
  content_type = "iso"
  datastore_id = "local"
  node_name    = var.prox_endpoint_name

  url = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
}

resource "proxmox_virtual_environment_download_file" "debian_cloud_image" {
  content_type = "iso" # Type has to be ISO
  datastore_id = "local"
  node_name    = var.prox_endpoint_name

  url                = "https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-genericcloud-amd64.raw"
  file_name          = "debian-12-genericcloud-amd64.img" # Tricks Proxmox into accepting non ISO/IMG file.
  checksum           = "5eebecaf296cb87a9b6431e7147b3cde7556c22d9cbdf3139a85ee212f297b561aea39debe2c1d14d0b4ba71d94b84ca2a904c9dfeb71aa9e04fe18fbe8855f1"
  checksum_algorithm = "sha512"
}