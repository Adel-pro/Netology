variable "token" {
  type        = string
  default     = ""
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  default     = ""
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  default     = ""
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "yandex_compute_instance_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "https://cloud.yandex.com/en/docs/cli/cli-ref/managed-services/compute/instance/"
}

variable "public_key" {
  type    = string
  default = "ssh-rsa "
}

variable "image_id" {
  type    = string
  default = "https://storage.yandexcloud.net/adel-image-storage/image.jpeg"
}
