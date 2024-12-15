resource "local_file" "hosts_templatefile" {
  depends_on = [
    yandex_compute_instance.masters,
    yandex_compute_instance.slaves,
    yandex_compute_instance.nat-instance,
  ]

  content = templatefile("${path.module}/hosts.tftpl",

    { masters      = yandex_compute_instance.masters[*],
      slaves       = yandex_compute_instance.slaves[*],
      nat_instance = yandex_compute_instance.nat-instance,
    }
  )
  filename = "${abspath(path.module)}/../ansible/hosts.yml"
}

resource "null_resource" "installation" {
  depends_on = [
    yandex_compute_instance.masters,
    yandex_compute_instance.slaves,
    yandex_compute_instance.nat-instance,
  ]

  provisioner "local-exec" {
    command = "export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -i ../ansible/hosts.yml -b ../ansible/installation.yml"
  }

}
