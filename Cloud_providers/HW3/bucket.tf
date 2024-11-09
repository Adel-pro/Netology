# Create bucket
resource "yandex_storage_bucket" "adel-04-11" {
  access_key    = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key    = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket        = "adel-image-storage"
  acl           = "public-read"
  force_destroy = "true"
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.adel-secret-key.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
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
