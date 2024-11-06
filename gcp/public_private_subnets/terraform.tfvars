gcp_project_id     = "amazing-autumn-440715-d4"
region             = "us-central1"
ssh_pub_key        = "~/.ssh/id_ed25519.pub"
keyfile_location   = "/home/hadi/code/gcp/service-account.json"
prefix             = "development"

machines = {
  vm-0 = {
    node_type = "public"
    size      = "e2-medium"
    zone      = "us-central1-a"
    boot_disk = {
      image_name = "ubuntu-os-cloud/ubuntu-2204-jammy-v20240927"
      size       = 20
    }
  },
  vm-1 = {
    node_type = "private"
    size      = "e2-medium"
    zone      = "us-central1-a"
    boot_disk = {
      image_name = "ubuntu-os-cloud/ubuntu-2204-jammy-v20240927"
      size       = 20
    }
  },
}
