resource "yandex_vpc_network" "develop" {
  name = var.name
}
# resource "yandex_vpc_subnet" "develop" {
#   name           = var.name
#   zone           = var.zone
#   network_id     = yandex_vpc_network.develop.id
#   v4_cidr_blocks = var.v4_cidr_blocks
# }

# Task 4
resource "yandex_vpc_subnet" "develop" {
  for_each = {
    for index, net in var.subnets :
  net.zone => net }
  name           = "${var.name}-${each.key}"
  zone           = each.value.zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = [each.value.cidr]
}
