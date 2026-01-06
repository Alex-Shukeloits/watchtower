terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.46.4"
    }
  }
}
variable "proxmox_api_token" {
  description = "Proxmox API token for authentication"
  type        = string
  sensitive   = true  # Hides value in logs
}

provider "proxmox" {
  endpoint = "https://100.97.185.188:8006/api2/json"
  ###api_token = "terraform@pve!tkn={{token}}"
  api_token = var.proxmox_api_token
  insecure = true
  }
  
