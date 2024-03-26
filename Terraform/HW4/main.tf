# resource "yandex_vpc_network" "develop" {
#   name = "develop"
# }

# resource "yandex_vpc_subnet" "develop" {
#   name           = "develop-ru-central1-a"
#   zone           = "ru-central1-a"
#   network_id     = yandex_vpc_network.develop.id
#   v4_cidr_blocks = ["10.0.1.0/24"]
# }
