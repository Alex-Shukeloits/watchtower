variable "vm_count" {
  description = "Number of VMs to create"
  type        = number
  default     = 3
}

variable "base_vm_id" {
  description = "Starting VM ID"
  type        = number
  default     = 1000
}

variable "base_ip" {
  description = "Starting IP address"
  type        = string
  default     = "192.168.0.200"
}


resource "proxmox_virtual_environment_vm" "test_vm" {
  count = 3
  name      = "vm-${count.index + 1}"
  node_name = "pve"
  started   = true
  vm_id     = var.base_vm_id + count.index 

  # Clone from template
  clone {
    vm_id = 777  # Your template VM ID
  }

  cpu {
    cores = 1
  }

  memory {
    dedicated = 1024
  }

  disk {
    datastore_id = "local-lvm"
    interface    = "scsi0"
    size         = 40
  }

  network_device {
    bridge = "vmbr0"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "${cidrhost("192.168.0.0/24", 200 + count.index)}/24"  #starting creation from address 192.168.0.200
        gateway = "192.168.0.1"
      }
    }
  }
}
