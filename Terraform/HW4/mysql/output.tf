output "mysql_name" {
  description = "yandex_mysql_name"
  value       = yandex_mdb_mysql_cluster.db.name
}

output "mysql_network_id" {
  description = "yandex_mysql_network_id"
  value       = yandex_mdb_mysql_cluster.db.id
}
