vms_resources = {
    cores = "2"
    memory = "1"
    core_fraction = "20"
}


# metadata = {
#     serial-port-enable = "1",
#     ssh-keys           = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
# }


each_vm = [ 
    {
        vm_name     = "main"
        cpu         = 2
        ram         = 2
        disk_volume = 8
    },
    {
        vm_name     = "replica"
        cpu         = 2
        ram         = 2
        disk_volume = 8
    }
]