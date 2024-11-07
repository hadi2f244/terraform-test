terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"  # Specify a version, e.g., ~> 3.0 for any 3.x version
    }
  }
}

provider "google" {
  credentials = file(var.keyfile_location)
  region      = var.region
  project     = var.gcp_project_id
}

