variable "business_unit" {
}

variable "location" {
  default = "southeastasia"
}

variable "username" {
}

variable "password" {
}

variable "vm_size" {
  default = "Standard_B2s"
}

variable "address_space" {
  default = "172.16.0.0/16"
}

variable "total" {
  default = 3
}

variable "aad_client_id" {
}

variable "aad_client_secret" {
}

variable "disk_size_gb" {
  default = 64
}

variable "has_zone" {
  default = false
}