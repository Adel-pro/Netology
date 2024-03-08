vms_resources = {
    web = {
        cores = "2"
        memory = "1"
        core_fraction = "20"
    },
    db = {
        cores = "2"
        memory = "2"
        core_fraction = "20"
    }
}


metadata = {
    serial-port-enable = "1",
    ssh-keys           = "ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCs7NoZG/oIkLgE6J9+WN2bz/DRNyPx8dsiFl9ycT1sUCgrUTOpGhj7eVP5hJhprWhrR6nWr7MOHHG/J3WfCZ3D06BElXQgSdvie9yj/h0Ptyjug/6uG0Jd0bYEULwRL1t3FQI8/+fuio9/IKyjZl5B5D1NDXw+BN/ic/zhh+GJXhkl+kgLtt6SPk0YvIfYXWhhBdO/1haDbU2X5BrP4pQ9l585D0T0QcoZ6MV53H+2FJen5GluqIjQ2drXVIYF870IVc50/pGNp2WJGyEQcl25A0z48oOJM5fQdq9j0RKbs4lW/J1H+oL9ovzwamcYHsA3exFFPeCVRJhbhLejxMDqRM3P7eNY7ES6f8hpOc681VcdxTsqTmmMLQl4ytMV6uDrgh5iJq0WjcHFqlCgQtakJEc9le/ZLtUrqv9H/56KQTPAlnuOPqhbdgWlJ/C7w4/qFK6I65IwxzSK0MdkEBNCZbaIUhvCdENWP0XZrqJS+tS3yNQJTiBGdzAabquFF4M= test@Netology"
}


test = [
  {
    "dev1" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@62.84.124.117",
      "10.0.1.7",
    ]
  },
  {
    "dev2" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@84.252.140.88",
      "10.0.2.29",
    ]
  },
  {
    "prod1" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@51.250.2.101",
      "10.0.1.30",
    ]
  },
]