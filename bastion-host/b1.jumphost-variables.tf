variable "jump_subnet_name" {
  type    = string
  default = "jumpsubnet"
}

variable "jump_subnet_address" {
  type    = list(string)
  default = ["10.0.2.0/24"]
}