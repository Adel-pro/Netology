locals {
    vm_name = "${var.coarse_name}-${var.vpc_name}-${var.base_name}-${var.destination_name}"

    metadata = {
        serial-port-enable = "1",
        ssh-keys           = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
    }
}
