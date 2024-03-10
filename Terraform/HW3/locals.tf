locals {
    vm_name = "${var.coarse_name}-${var.vpc_name}-${var.base_name}-${var.destination_name}"

    # each_vm = [ 
    #     {
    #         vm_name     = "main"
    #         cpu         = 2
    #         ram         = 1
    #         disk_volume = 8
    #     },
    #     {
    #         vm_name     = "replica"
    #         cpu         = 2
    #         ram         = 1
    #         disk_volume = 8
    #     }
    # ]

    metadata = {
        serial-port-enable = "1",
        ssh-keys           = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
    }
}