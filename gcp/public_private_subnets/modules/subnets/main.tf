resource "google_compute_network" "vpc_network" {
  name = "${var.prefix}-network"

  auto_create_subnetworks = false
}


# Define firewall rule to allow all incoming SSH traffic
resource "google_compute_firewall" "allow_ssh" {
  name    = "${var.prefix}-allow-ssh"
  network       = google_compute_network.vpc_network.id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]  # Allow SSH from anywhere
}

# Define firewall rule to allow all outgoing traffic to the internet
resource "google_compute_firewall" "allow_egress" {
  name    = "${var.prefix}-allow-egress"
  network       = google_compute_network.vpc_network.id

  allow {
    protocol = "all"
  }

  direction = "EGRESS"
  destination_ranges = ["0.0.0.0/0"]  # Allow all outbound traffic to anywhere
}

# Public Subnet (with external IPs enabled)
resource "google_compute_subnetwork" "public_subnet" {
  name          = "${var.prefix}-public-subnet"
  region        = var.region
  network       = google_compute_network.vpc_network.id
  ip_cidr_range = "10.0.1.0/24"
  # Enable private IP access
  private_ip_google_access = true
}

# Private Subnet (no external IPs)
resource "google_compute_subnetwork" "private_subnet" {
  name          = "${var.prefix}-private-subnet"
  region        = var.region
  network       = google_compute_network.vpc_network.id
  ip_cidr_range = "10.0.2.0/24"
  private_ip_google_access = true  # Allow private Google API access
}

# Create Cloud NAT for the private subnet (for internet access without public IP)
resource "google_compute_router" "nat_router" {
  name    = "${var.prefix}-nat-router"
  network = google_compute_network.vpc_network.id
  region  = var.region
}

resource "google_compute_router_nat" "cloud_nat" {
  name                               = "${var.prefix}-cloud-nat"
  router                             = google_compute_router.nat_router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = google_compute_subnetwork.private_subnet.name
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}

# Example public instance with external IP in the public subnet
resource "google_compute_instance" "public_instance" {
  for_each = {
      for name, machine in var.machines :
      name => machine
      if machine.node_type == "public"
  }
  name         = "${var.prefix}-public-instance-${each.key}"
  machine_type = each.value.size
  zone         = each.value.zone

  tags = ["public", each.key]

  boot_disk {
    initialize_params {
      image = each.value.boot_disk.image_name
      size = each.value.boot_disk.size
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.public_subnet.name
    access_config {} # Grants external IP
  }

  metadata = {
    ssh-keys = "ubuntu:${trimspace(file(pathexpand(var.ssh_pub_key)))}"
  }
}

# Example private instance without external IP in the private subnet
resource "google_compute_instance" "private_instance" {
  for_each = {
      for name, machine in var.machines :
      name => machine
      if machine.node_type == "private"
  }
  name         = "${var.prefix}-private-instance-${each.key}"
  machine_type = each.value.size
  zone         = each.value.zone

  tags = ["private", each.key]

  boot_disk {
    initialize_params {
      image = each.value.boot_disk.image_name
      size = each.value.boot_disk.size
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.private_subnet.name
  }

  metadata = {
    ssh-keys = "ubuntu:${trimspace(file(pathexpand(var.ssh_pub_key)))}"
  }
}