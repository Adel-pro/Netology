resource "local_file" "webhosts_templatefile" {
    content = templatefile("${path.module}/hosts.tftpl",

    { webservers = yandex_compute_instance.web, 
      dbservers = yandex_compute_instance.db,
      diskservers = yandex_compute_instance.storage})

    filename = "${abspath(path.module)}/hosts.cfg"
}

# resource "local_file" "dbhosts_templatefile" {
#     content = templatefile("${path.module}/hosts.tftpl",

#     { dbservers = yandex_compute_instance.db })

#     filename = "${abspath(path.module)}/hosts.cfg"
# }

# resource "local_file" "hosts_for" {
#     content =  <<-EOT
#     %{if length(yandex_compute_instance.vm_disk) > 0}
#     [webservers]
#     %{endif}
#     %{for i in yandex_compute_instance.vm_disk }
#     ${i["name"]}   ansible_host=${i["network_interface"][0]["nat_ip_address"]}
#     %{endfor}
#     EOT
#     filename = "${abspath(path.module)}/for.cfg"

# }