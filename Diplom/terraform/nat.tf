# Create a NAT instance
resource "yandex_compute_instance" "nat-instance" {
  name                      = var.nat_instance_name
  platform_id               = var.vm_platform
  allow_stopping_for_update = true
  zone                      = var.subnets[0]

  resources {
    cores         = var.vms_resources.nat_vm.cores
    memory        = var.vms_resources.nat_vm.memory
    core_fraction = var.vms_resources.nat_vm.core_fraction
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
    subnet_id  = yandex_vpc_subnet.public_subnet.id
    ip_address = "192.168.1.254"
    nat        = true
  }

  metadata = {
    serial-port-enable = local.metadata.serial-port-enable
    ssh-keys           = local.metadata.ssh-keys
  }
}

# Create a route table and static route
resource "yandex_vpc_route_table" "netology-route" {
  name       = "private-into-nat"
  network_id = yandex_vpc_network.netology-net.id
  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = "192.168.1.254"
  }
}
