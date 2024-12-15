# Create bucket
resource "yandex_storage_bucket" "bucket-terraform" {
  access_key    = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key    = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket        = "bucket-terraform"
  acl           = "private"
  force_destroy = "true"
}
