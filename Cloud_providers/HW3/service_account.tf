# Create service account for Object Storage
resource "yandex_iam_service_account" "adel-sa" {
  name = "adel-sa"
}

# Create role for service account
resource "yandex_resourcemanager_folder_iam_member" "adel-sa-editor" {
  folder_id = var.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.adel-sa.id}"
}

# Create role for service account
resource "yandex_resourcemanager_folder_iam_member" "adel-sa-editor-encrypt" {
  folder_id = var.folder_id
  role      = "kms.keys.encrypterDecrypter"
  member    = "serviceAccount:${yandex_iam_service_account.adel-sa.id}"
}

# Create symmetric key
resource "yandex_kms_symmetric_key" "adel-secret-key" {
  name              = "key-1"
  default_algorithm = "AES_128"
  rotation_period   = "24h"
  description       = "key for bucket encryption"
}

# Create static access key
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.adel-sa.id
  description        = "static key for object storage"
}
