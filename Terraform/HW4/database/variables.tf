variable "name" {
  type        = string
  description = "Database name"
}

variable "id" {
  type        = string
  description = "Cluster id"
}

variable "zone1" {
  type        = string
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "username" {
  type        = string
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "password" {
  type        = string
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}
