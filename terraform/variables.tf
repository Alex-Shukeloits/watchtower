variable "vm_count" {
  description = "Number of VMs to create"
  type        = number
  default     = 4
}

variable "base_vm_id" {
  description = "Starting VM ID"
  type        = number
  default     = 1000
}

variable "base_ip" {
  description = "Base IP used for first VM"
  type        = string
  default     = "192.168.0.200"
}

variable "template_vm_id" {
  description = "Template VM ID for cloning"
  type        = number
  default     = 778
}

variable "proxmox_node" {
  description = "Proxmox node name"
  type        = string
  default     = "pve"
}
