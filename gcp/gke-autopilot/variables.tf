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