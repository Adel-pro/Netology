output "vm_web" {
    value = [
        yandex_compute_instance.platform.name,
        yandex_compute_instance.platform.network_interface.0.nat_ip_address,
        yandex_compute_instance.plat_db.name
    ]
}

output "vm_db" {
    value = [
        yandex_compute_instance.plat_db.name,
        yandex_compute_instance.plat_db.network_interface.0.nat_ip_address,
        yandex_compute_instance.plat_db.fqdn
    ]
}

