output "vm_ids" {
  description = "List of Proxmox VM IDs created"
  value       = [for vm in proxmox_virtual_environment_vm.test_vm : vm.vm_id]
}

output "vm_ips" {
  description = "List of VM IP addresses"
  value       = [for vm in proxmox_virtual_environment_vm.test_vm : vm.initialization[0].ip_config[0].ipv4[0].address]
}

output "vm_names" {
  description = "List of VM names"
  value       = [for vm in proxmox_virtual_environment_vm.test_vm : vm.name]
}

