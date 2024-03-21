###cloud vars
variable "token" {
  type        = string
  default     = "y0_AgAAAAAJg00aAATuwQAAAAD8q8IIAABwG8BVwURJIKLzGmk4rCpr2eAPhA"
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  default     = "b1g0tjionpev7789mnku"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  default     = "b1g1m1aklj2nnna7878o"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "vm_image" {
  type = string
  default = "ubuntu-2004-lts"
  description = "VM image"
}

variable "vm_platform" {
  type        = string
  default     = "standard-v3"
  description = "Platform"
}

variable "coarse_name" {
  type        = string
  default     = "netology"
  description = "Coarse name"
}

variable "base_name" {
  type        = string
  default     = "platform"
  description = "Base name"
}

variable "destination_name" {
  type        = string
  default     = "web"
  description = "Destination name"
}


variable "vms_resources" {
  type = map(string)
}

variable "each_vm" {
  type = list(object({  vm_name=string, cpu=number, ram=number, disk_volume=number }))
}
