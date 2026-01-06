locals {
  vms = {
    # -------- VMs on pve --------
    master1 = {
      node        = "pve"
      vm_id       = 253
      template_id = 778
      cpu         = 2
      memory      = 2048
      disk_size   = 32
      ip          = "192.168.0.119"
    }

    master2 = {
      node        = "pve"
      vm_id       = 254
      template_id = 778
      cpu         = 2
      memory      = 4096
      disk_size   = 32
      ip          = "192.168.0.120"
    }

    # -------- VM on pve2 --------
    worker1 = {
      node        = "pve2"
      vm_id       = 305
      template_id = 781
      cpu         = 2
      memory      = 2048
      disk_size   = 32
      ip          = "192.168.0.121"
    }
  }
}

resource "proxmox_virtual_environment_vm" "vms" {
  for_each = local.vms

  name      = each.key
  node_name = each.value.node
  vm_id     = each.value.vm_id
  started   = true

  clone {
    vm_id = each.value.template_id
  }

  cpu {
    cores = each.value.cpu
  }

  memory {
    dedicated = each.value.memory
  }

  disk {
    datastore_id = "local-lvm"  # Adjust if you use vmdata etc.
    interface    = "scsi0"
    size         = each.value.disk_size
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
