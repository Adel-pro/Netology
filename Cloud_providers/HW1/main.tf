# Create a network
resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

# Create a subnets
resource "yandex_vpc_subnet" "public" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

resource "yandex_vpc_subnet" "private" {
  name           = var.private_subnet
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.private_cidr
  route_table_id = yandex_vpc_route_table.nat-instance-route.id
}

# Create a NAT instance
resource "yandex_compute_instance" "nat-instance" {
  name        = var.nat_instance_name
  platform_id = var.yandex_compute_instance_platform_id

  resources {
    core_fraction = 20
    cores         = 2
    memory        = 1
  }

  boot_disk {
    initialize_params {
      image_id = "fd80mrhj8fl2oe87o4e1"
    }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.public.id
    ip_address = "192.168.10.254"
    nat        = true
  }

  metadata = {
    serial-port-enable = var.metadata_map.metadata["serial-port-enable"]
    ssh-keys           = "${local.ssh_key}"
  }
}

# Create a route table and static route
resource "yandex_vpc_route_table" "nat-instance-route" {
  name       = "private-into-nat"
  network_id = yandex_vpc_network.develop.id
  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = "192.168.10.254"
  }
}

data "yandex_compute_image" "ubuntu" {
  family = var.yandex_compute_image
}

# Create a Private VM
resource "yandex_compute_instance" "vm-private" {
  name        = var.private_instance_name
  platform_id = var.yandex_compute_instance_platform_id
  resources {
    core_fraction = 20
    cores         = 2
    memory        = 1
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.private.id
    nat       = false
  }

  metadata = {
    serial-port-enable = var.metadata_map.metadata["serial-port-enable"]
    ssh-keys           = "${local.ssh_key}"
  }
}
