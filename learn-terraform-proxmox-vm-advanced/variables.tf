variable "prox_endpoint" {
  type        = string
  description = "Proxmox API Endpoint"
}

variable "prox_username" {
  type        = string
  description = "Username for Proxmox API authentication"
}

variable "prox_password" {
  type        = string
  description = "Password for Proxmox API authentication"
}

variable "prox_endpoint_name" {
  type        = string
  description = "Name of the Proxmox API endpoint"
}

variable "default_account_username" {
  type        = string
  description = "Username for cloud-init user account"
}

variable "default_account_password" {
  type        = string
  description = "Password for cloud-init user account."
}