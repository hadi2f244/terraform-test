# output "public_instance" {
#   value = {
#     for key, instance in google_compute_instance.public_instance :
#     instance.name => {
#       "private_ip" = lookup(instance.network_interface[0], "network_ip", "")
#       "public_ip"  = length(instance.network_interface) > 0 && length(instance.network_interface[0].access_config) > 0 ? instance.network_interface[0].access_config[0].nat_ip : ""
#     }
#   }
# }

# output "private_instance" {
#   value = {
#     for key, instance in google_compute_instance.private_instance :
#     instance.name => {
#       "private_ip" = lookup(instance.network_interface[0], "network_ip", "")
#       "public_ip"  = length(instance.network_interface) > 0 && length(instance.network_interface[0].access_config) > 0 ? instance.network_interface[0].access_config[0].nat_ip : ""
#     }
#   }
# }


output "gke_name" {
    value = google_container_cluster.primary.name
}