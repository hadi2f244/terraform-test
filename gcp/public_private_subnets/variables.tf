variable keyfile_location {
  description = "Location of the json keyfile to use with the google provider"
  type        = string
}

variable region {
  description = "Region of all resources"
  type        = string
}

variable gcp_project_id {
  description = "ID of the project"
  type        = string
}

variable prefix {
  description = "Prefix for resource names"
  default     = "default"
}

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

variable ssh_pub_key {
  description = "Path to public SSH key file which is injected into the VMs."
  type        = string
}