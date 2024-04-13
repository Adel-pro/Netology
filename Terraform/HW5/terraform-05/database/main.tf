resource "yandex_mdb_mysql_database" "mysql_test" {
  cluster_id = var.id
  name       = var.name
}

resource "yandex_mdb_mysql_user" "app" {
  cluster_id = var.id
  name       = var.username
  password   = var.password
  permission {
    database_name = var.name
    roles         = ["SELECT"]
  }
}
