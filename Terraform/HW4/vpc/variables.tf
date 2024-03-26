# variable "zone" {
#   type        = string
#   description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
# }
# variable "v4_cidr_blocks" {
#   type        = list(string)
#   description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
# }

variable "subnets" {
  type = list(object({ zone = string, cidr = string }))
}

variable "name" {
  type        = string
  description = "VPC network&subnet name"
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
