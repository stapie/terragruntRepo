
variable "region" {
  type    = string
}

variable "profile" {
  type    = string
}

variable "instance-type" {
  type    = string
}

variable "security_group_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "main_route_table_association" {
  type = string
}
