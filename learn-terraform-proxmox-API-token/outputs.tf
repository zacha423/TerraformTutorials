output "node_names" {
  description = "Name of all nodes in Proxmox cluster"
  value       = data.proxmox_virtual_environment_nodes.availableNodes.names
}

output "node_status" {
  description = "Status of all nodes in Proxmox Cluster"
  value       = data.proxmox_virtual_environment_nodes.availableNodes.online
}