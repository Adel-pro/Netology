###cloud vars
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
  description = "VPC network & subnet name"
}

variable "vm_web_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "VM image" 
}

variable "vm_web_platform" {
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

variable "destination_web_name" {
  type        = string
  default     = "web"
  description = "Destination name"
}


###ssh vars

variable "vms_ssh_public_root_key" {
  type        = string
  default     = "/home/test/.ssh/id_rsa.pub"
  description = "ssh-keygen -t ed25519"
}

variable "vms_ssh_root_key" {
  type        = string
  default     = "/home/test/.ssh/id_rsa"
  description = "ssh-keygen -t ed25519"
}



variable "vms_resources" {
  type = map(any)
}

variable "metadata" {
  type = map(string)
}


variable "test" {
  type = list(map(list(string)))
}