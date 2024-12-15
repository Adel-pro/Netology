# Create a network
resource "yandex_vpc_network" "netology-net" {
  name = var.vpc_name
}

# Create a private subnets
resource "yandex_vpc_subnet" "private_subnet" {
  count          = length(var.subnets)
  name           = "private_${var.subnets[count.index]}"
  zone           = var.subnets[count.index]
  network_id     = yandex_vpc_network.netology-net.id
  v4_cidr_blocks = [var.private_cidr[count.index]]
  route_table_id = yandex_vpc_route_table.netology-route.id
}

# Create a public subnets
resource "yandex_vpc_subnet" "public_subnet" {
  name           = "public_${var.vpc_name}"
  zone           = var.subnets[0]
  network_id     = yandex_vpc_network.netology-net.id
  v4_cidr_blocks = var.public_cidr
}
