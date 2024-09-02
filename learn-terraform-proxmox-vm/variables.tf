variable "proxmox_endpoint" {
  type        = string
  description = "The API endpoint for the Proxmox Node E.g. 'https://mynode:8006'"
}

variable "proxmox_username" {
  type        = string
  description = "The username for authentication with the Proxmox endpoint."
}

variable "proxmox_password" {
  type        = string
  sensitive   = true
  description = "Password for authentication with the Proxmox endpoint"
}

variable "cluster_node_1" {
  type        = string
  description = "The name of the first node in the Proxmox cluster."
}

variable "cluster_node_2" {
  type        = string
  description = "The name of the second node in the Proxmox cluster"
  nullable    = true
}

variable "cluster_node_3" {
  type        = string
  description = "The name of the third node in the Proxmox cluster"
  nullable    = true
}

