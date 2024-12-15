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

variable "subnets" {
  type    = list(string)
  default = ["ru-central1-a", "ru-central1-b", "ru-central1-d"]
}

variable "private_cidr" {
  type    = list(string)
  default = ["10.10.10.0/24", "10.10.20.0/24", "10.10.30.0/24"]
}

variable "public_cidr" {
  type    = list(string)
  default = ["192.168.1.0/24"]
}

variable "vms_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number

  }))
}

variable "vm_platform" {
  type        = string
  default     = "standard-v3"
  description = "Platform"
}

variable "vm_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "VM image"
}

variable "nat_instance_name" {
  type        = string
  default     = "nat-instance"
  description = "Nat instance name"
}
