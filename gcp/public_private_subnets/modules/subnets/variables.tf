variable "region" {
  type = string
}

variable "prefix" {}

variable "machines" {
  type = map(object({
    node_type = string
    size      = string
    zone      = string
    boot_disk = object({
      image_name = string
      size       = number
    })
  }))
}

variable "ssh_pub_key" {}

