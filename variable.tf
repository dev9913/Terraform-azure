variable "env" {
  description = "Environment name. Example: dev, test, production"
  type        = string
  default     = "production"
}

variable "location" {
  description = "Azure region. like: eastus, westeurope, uksouth"
  type        = string
  default     = "eastus"
}

variable "name" {
   description = "Write VM Name "
   type = string
   default = "terraform"
}

variable "vm_size" {
  type        = string
  description = "VM size. Example: Standard_B1s, Standard_F2, Standard_D2s_v3"
  default     = "Standard_B1s"
}


variable "vm_image_publisher" {
  type        = string
  description = "Example: Canonical, MicrosoftWindowsServer"
  default     = "Canonical"
}

variable "vm_image_offer" {
  type        = string
  description = "Example: 0001-com-ubuntu-server-jammy, WindowsServer"
  default     = "0001-com-ubuntu-server-jammy"
}

variable "vm_image_sku" {
  type        = string
  description = "Example: 22_04-lts, 2022-Datacenter"
  default     = "22_04-lts"
}

variable "vm_image_version" {
  type        = string
  description = "Example: latest, 22.04.202404240"
  default     = "latest"
}

variable "storage_type" {
  type = string
  description = "Enter Storage Account Type like: Standard_LRS , StandardSSD_LRS , Premium_LRS "
  default = "Standard_LRS"
}

variable "storage_size"{
  type = number
  description = "Enter Storege Size  like : 10, 20 , 30 gb."
  default = 30

}

# --------------Storage Account details----------------

variable "storage_account_name" {
  description = "Globally unique storage account name"
  type        = string
  default     = "tfstatestorage123"
}

variable "account_tier" {
  description = "Storage account tier: Standard or Premium"
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Storage account replication type: LRS, GRS, RA-GRS"
  type        = string
  default     = "LRS"
}

