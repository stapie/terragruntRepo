variable "region" {
  description = "aws region"
  type    = string
}


variable "ingress-port" {
  type = number
}

variable "egress-port" {
  type = number
}
