# output "public_instance" {
#   value = module.subnets.public_instance
# }

# output "private_instance" {
#   value = module.subnets.private_instance
# }

output "gke_name" {
    value = module.gke.gke_name
}