variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "rules_map" {
    type = map(string)
    default = {
      80 = "0.0.0.0/0"
      443 = "192.168.1.0/24"
      8080 = "192.168.1.0/24"
      22 = "10.0.0.0/16"
    }
}