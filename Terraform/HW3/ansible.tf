resource "local_file" "webhosts_templatefile" {
    content = templatefile("${path.module}/hosts.tftpl",

    { webservers = yandex_compute_instance.web, 
      dbservers = yandex_compute_instance.db,
      diskservers = yandex_compute_instance.storage.*})

    filename = "${abspath(path.module)}/hosts.cfg"
}
