resource "yandex_container_registry" "my-reg" {
  name      = "netology-registry"
  folder_id = var.folder_id
  labels = {
    my-label = "docker-images"
  }
}

resource "yandex_container_registry_iam_binding" "puller" {
  registry_id = yandex_container_registry.my-reg.id
  role        = "container-registry.images.pusher"

  members = [
    "system:allUsers",
  ]
}

resource "yandex_container_registry_iam_binding" "pusher" {
  registry_id = yandex_container_registry.my-reg.id
  role        = "container-registry.images.puller"

  members = [
    "system:allUsers",
  ]
}
