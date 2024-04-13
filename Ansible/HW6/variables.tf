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
  description = "VPC network&subnet name"
}

###common vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "your_ssh_ed25519_key"
  description = "ssh-keygen -t ed25519"
}

###example vm_web var
variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "example vm_web_ prefix"
}

###example vm_db var
variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "example vm_db_ prefix"
}

variable "ssh_public_key" {
  type    = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCs7NoZG/oIkLgE6J9+WN2bz/DRNyPx8dsiFl9ycT1sUCgrUTOpGhj7eVP5hJhprWhrR6nWr7MOHHG/J3WfCZ3D06BElXQgSdvie9yj/h0Ptyjug/6uG0Jd0bYEULwRL1t3FQI8/+fuio9/IKyjZl5B5D1NDXw+BN/ic/zhh+GJXhkl+kgLtt6SPk0YvIfYXWhhBdO/1haDbU2X5BrP4pQ9l585D0T0QcoZ6MV53H+2FJen5GluqIjQ2drXVIYF870IVc50/pGNp2WJGyEQcl25A0z48oOJM5fQdq9j0RKbs4lW/J1H+oL9ovzwamcYHsA3exFFPeCVRJhbhLejxMDqRM3P7eNY7ES6f8hpOc681VcdxTsqTmmMLQl4ytMV6uDrgh5iJq0WjcHFqlCgQtakJEc9le/ZLtUrqv9H/56KQTPAlnuOPqhbdgWlJ/C7w4/qFK6I65IwxzSK0MdkEBNCZbaIUhvCdENWP0XZrqJS+tS3yNQJTiBGdzAabquFF4M= test@Netology"
}
