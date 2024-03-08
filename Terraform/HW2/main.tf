resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}


data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image
}
resource "yandex_compute_instance" "platform" {
  name        = local.web_name
  platform_id = var.vm_web_platform
  resources {
    cores         = var.vms_resources.web.cores
    memory        = var.vms_resources.web.memory
    core_fraction = var.vms_resources.web.core_fraction
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
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = false
  }

  metadata = {
    # serial-port-enable = 1
    # ssh-keys           = "ubuntu:${var.vms_ssh_public_root_key}"
    # user-data = "#cloud-config\nusers:\n  - name: ubuntu\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh-authorized-keys:\n      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCs7NoZG/oIkLgE6J9+WN2bz/DRNyPx8dsiFl9ycT1sUCgrUTOpGhj7eVP5hJhprWhrR6nWr7MOHHG/J3WfCZ3D06BElXQgSdvie9yj/h0Ptyjug/6uG0Jd0bYEULwRL1t3FQI8/+fuio9/IKyjZl5B5D1NDXw+BN/ic/zhh+GJXhkl+kgLtt6SPk0YvIfYXWhhBdO/1haDbU2X5BrP4pQ9l585D0T0QcoZ6MV53H+2FJen5GluqIjQ2drXVIYF870IVc50/pGNp2WJGyEQcl25A0z48oOJM5fQdq9j0RKbs4lW/J1H+oL9ovzwamcYHsA3exFFPeCVRJhbhLejxMDqRM3P7eNY7ES6f8hpOc681VcdxTsqTmmMLQl4ytMV6uDrgh5iJq0WjcHFqlCgQtakJEc9le/ZLtUrqv9H/56KQTPAlnuOPqhbdgWlJ/C7w4/qFK6I65IwxzSK0MdkEBNCZbaIUhvCdENWP0XZrqJS+tS3yNQJTiBGdzAabquFF4M= test@Netology"
    # user-data = "${file("~/Downloads/ter-homeworks/02/src/ssh.txt")}"
    serial-port-enable = var.metadata.serial-port-enable
    ssh-keys           = var.metadata.ssh-keys
  }

}


# resource "yandex_vpc_network" "develop" {
#   name = var.vpc_name_db
# }

resource "yandex_vpc_subnet" "develop_db" {
  name           = var.vpc_name_db
  zone           = var.default_zone_db
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr_db
}

resource "yandex_compute_instance" "plat_db" {
  name        = local.db_name
  platform_id = var.vm_db_platform
  zone        = "ru-central1-b"
  resources {
    cores         = var.vms_resources.db.cores
    memory        = var.vms_resources.db.memory
    core_fraction = var.vms_resources.db.core_fraction
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
    subnet_id = yandex_vpc_subnet.develop_db.id
    nat       = true
  }

  metadata = {
    # serial-port-enable = 1
    # ssh-keys           = "ubuntu:${var.vms_ssh_public_root_key}"
    # user-data = "#cloud-config\nusers:\n  - name: ubuntu\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh-authorized-keys:\n      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCs7NoZG/oIkLgE6J9+WN2bz/DRNyPx8dsiFl9ycT1sUCgrUTOpGhj7eVP5hJhprWhrR6nWr7MOHHG/J3WfCZ3D06BElXQgSdvie9yj/h0Ptyjug/6uG0Jd0bYEULwRL1t3FQI8/+fuio9/IKyjZl5B5D1NDXw+BN/ic/zhh+GJXhkl+kgLtt6SPk0YvIfYXWhhBdO/1haDbU2X5BrP4pQ9l585D0T0QcoZ6MV53H+2FJen5GluqIjQ2drXVIYF870IVc50/pGNp2WJGyEQcl25A0z48oOJM5fQdq9j0RKbs4lW/J1H+oL9ovzwamcYHsA3exFFPeCVRJhbhLejxMDqRM3P7eNY7ES6f8hpOc681VcdxTsqTmmMLQl4ytMV6uDrgh5iJq0WjcHFqlCgQtakJEc9le/ZLtUrqv9H/56KQTPAlnuOPqhbdgWlJ/C7w4/qFK6I65IwxzSK0MdkEBNCZbaIUhvCdENWP0XZrqJS+tS3yNQJTiBGdzAabquFF4M= test@Netology"
    # user-data = "${file("~/Downloads/ter-homeworks/02/src/ssh.txt")}"
    serial-port-enable = var.metadata.serial-port-enable
    ssh-keys           = var.metadata.ssh-keys
  }

}
