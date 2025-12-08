This repo is dedicated to deplyment of infrastructure based on Proxmox, automated VMs creation with services running on them. 
Deployment tool: Ansible & Terraform


VMs and VM templates can be created via Ansible.
Terraform uses created templated.

###################################################
For terraform in terraform dir:

  terraform plan  -var="vm_count=1"
  terraform apply  -var="vm_count=1"

#number of VMs needs to be specified in vm_count
###################################################
