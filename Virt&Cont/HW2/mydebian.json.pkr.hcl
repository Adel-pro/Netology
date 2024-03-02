source "yandex" "debian_docker" {
  disk_type           = "network-hdd"
  folder_id           = "b1g1m1aklj2nnna7878o"
  image_description   = "my custom debian with docker"
  image_name          = "debian-11-docker"
  source_image_family = "debian-11"
  ssh_username        = "debian"
  subnet_id           = "e2lu3j350bevadt2siiu"
  token	              = "xxxxx"
  use_ipv4_nat        = true
  zone                = "ru-central1-b"
}

build {
  sources = ["source.yandex.debian_docker"]

  provisioner "shell" {
    inline = [
      "echo 'hello from packer'",
      "<<-EOF",
      "export DEBIAN_FRONTEND=noninteractive",
      "sudo apt-get update",
      "sudo apt-get install ca-certificates curl gnupg",
      "sudo install -m 0755 -d /etc/apt/keyrings",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg",
      "sudo chmod a+r /etc/apt/keyrings/docker.gpg",
      "echo",
      " 'deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu",
      "$(. /etc/os-release && echo '$VERSION_CODENAME') stable' | ",
      "sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
      "sudo apt-get update",
      "sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin",
      "EOF",
      "sudo apt install -y htop",
      "sudo apt update",
      "sudo apt install -y tmux"
    ]
  }
}
