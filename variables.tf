variable "location" {
  type    = string
  default = "eastus"
}

variable "vnet_address_space" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_address_spaces" {
  type    = list(string)
  default = ["10.0.0.0/24"]
}

variable "size" {
  type    = string
  default = "Standard_DS1_v2"
}
