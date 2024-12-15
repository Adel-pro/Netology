data "yandex_compute_image" "ubuntu" {
  family = var.vm_image
}

resource "yandex_compute_instance" "masters" {
  name        = "master"
  hostname    = "master"
  platform_id = var.vm_platform
  zone        = var.subnets[0]

  resources {
    cores         = var.vms_resources.masters_vm.cores
    memory        = var.vms_resources.masters_vm.memory
    core_fraction = var.vms_resources.masters_vm.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = 15
    }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.private_subnet[0].id
    nat       = false
  }

  metadata = {
    serial-port-enable = local.metadata.serial-port-enable
    ssh-keys           = local.metadata.ssh-keys
  }

}


resource "yandex_compute_instance" "slaves" {
  count       = 2
  name        = "slave-${count.index + 1}"
  hostname    = "slave-${count.index + 1}"
  platform_id = var.vm_platform
  zone        = var.subnets[count.index]

  resources {
    cores         = var.vms_resources.slaves_vm.cores
    memory        = var.vms_resources.slaves_vm.memory
    core_fraction = var.vms_resources.slaves_vm.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = 15
    }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.private_subnet[count.index].id
    nat       = false
  }

  metadata = {
    serial-port-enable = local.metadata.serial-port-enable
    ssh-keys           = local.metadata.ssh-keys
  }

}
