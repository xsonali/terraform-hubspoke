# variables.tf
# Declare all input variables here.
# variables.tf

variable "location" {
  description = "Azure region to deploy resources"
  type        = string
  default     = "australiaeast"
}

variable "admin_username" {
  description = "Admin username for VMs"
  type        = string
  default     = "azureadmin"
}

variable "admin_password" {
  description = "Admin password for VMs"
  type        = string
  sensitive   = true
}

variable "vm_size" {
  description = "Size of the virtual machines"
  type        = string
  default     = "Standard_B1s"
}

variable "firewall_private_ip" {
  description = "Private IP of Azure Firewall in the hub"
  type        = string
  default     = "10.0.0.4"
}
