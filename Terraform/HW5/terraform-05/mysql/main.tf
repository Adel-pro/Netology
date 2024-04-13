resource "yandex_mdb_mysql_cluster" "db" {
  name        = var.name
  environment = "PRESTABLE"
  network_id  = var.network_id
  version     = "8.0"

  resources {
    resource_preset_id = "s2.micro"
    disk_type_id       = "network-hdd"
    disk_size          = 16
  }

  maintenance_window {
    type = "WEEKLY"
    day  = "SAT"
    hour = 12
  }

  host {
    zone      = var.zone1
    subnet_id = var.subnet_id1
  }

  host {
    zone      = var.zone2
    subnet_id = var.subnet_id2
  }
}
