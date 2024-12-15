# Create service account for terraform
resource "yandex_iam_service_account" "sa-terraform" {
  name = "sa-terraform"
}

# Create role for service account
resource "yandex_resourcemanager_folder_iam_member" "terraform-editor" {
  folder_id  = var.folder_id
  role       = "editor"
  member     = "serviceAccount:${yandex_iam_service_account.sa-terraform.id}"
  depends_on = [yandex_iam_service_account.sa-terraform]
}

# resource "yandex_resourcemanager_folder_iam_member" "terraform-registry" {
#   folder_id  = var.folder_id
#   role       = "container-registry.images.pusher"
#   member     = "serviceAccount:${yandex_iam_service_account.sa-terraform.id}"
#   depends_on = [yandex_iam_service_account.sa-terraform]
# }

# Create static access key
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa-terraform.id
  description        = "static access key"
}
