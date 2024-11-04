# Create bucket
resource "yandex_storage_bucket" "adel-04-11" {
  access_key    = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key    = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket        = "adel-image-storage"
  acl           = "public-read"
  force_destroy = "true"
}

# create object in a bucket
resource "yandex_storage_object" "image-object" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = "adel-image-storage"
  acl        = "public-read"
  key        = "image.jpeg"
  source     = "~/Downloads/cloud_netology/hw2/image.jpeg"
  depends_on = [yandex_storage_bucket.adel-04-11]
}
