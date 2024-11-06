module "subnets" {
  source = "./modules/subnets"
  region = var.region
  prefix = var.prefix

  machines    = var.machines
  ssh_pub_key = var.ssh_pub_key
}