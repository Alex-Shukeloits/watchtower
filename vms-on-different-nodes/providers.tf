terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.46.4"
    }
  }
}

provider "proxmox" {
  endpoint = "https://100.97.185.188:8006/api2/json"
  api_token = "terraform@pve!tkn={{token}}"
  insecure = true
  }
  
