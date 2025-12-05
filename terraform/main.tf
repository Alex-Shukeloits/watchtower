locals {
  # Convert base_ip to integer host index
  base_ip_index = tonumber(split(".", var.base_ip)[3])

  # Create a stable map of VMs
  vms = {
    for i in range(var.vm_count) :
    i => {
      vm_id = var.base_vm_id + i
      ip    = cidrhost("192.168.0.0/24", local.base_ip_index + i)
    }
  }
}
resource "proxmox_virtual_environment_vm" "test_vm" {
  for_each  = local.vms

  name      = "computer-${each.key + 1}"
  node_name = var.proxmox_node
  started   = true
  vm_id     = each.value.vm_id

  clone {
    vm_id = var.template_vm_id
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
    size         = 45
  }

  network_device {
    bridge = "vmbr0"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "${each.value.ip}/24"
        gateway = "192.168.0.1"
      }
    }
  }

  lifecycle {
    ignore_changes = [
      initialization,
      network_device,
    ]
  }
}
