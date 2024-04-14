###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
  validation {
    condition     = length(var.token) >= 32
    error_message = "token must include at least 32 characters"
  }
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
  validation {
    condition     = length(var.cloud_id) == 20
    error_message = "cloud_id must have 20 characters"
  }
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
  validation {
    condition     = length(var.folder_id) == 20
    error_message = "folder_id must have 20 characters"
  }
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
  validation {
    condition     = contains(["ru-central1-a", "ru-central1-b", "ru-central1-c", "ru-central1-d"], var.default_zone)
    error_message = "Invalid zone provided"
  }
}

# variable "default_cidr" {
#   type        = string
#   default     = "10.0.1.0/24"
#   description = "ip address"
#   validation {
#     condition     = can(cidrhost(var.default_cidr, 32))
#     error_message = "Must be valid IPv4 CIDR"
#   }
# }

# variable "default_cidr" {
#   type        = list(string)
#   default     = ["10.0.1.0/24"]
#   description = "list of ip addresses"

#   dynamic "validation {
#     for_each = var.default_cidr
#     content {
#       condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}$", var.default_cidr.value))
#       error_message = "Must be valid IPv4 CIDR"
#     }
#   }
# }

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "list of ip addresses"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "ssh_public_key" {
  type    = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCs7NoZG/oIkLgE6J9+WN2bz/DRNyPx8dsiFl9ycT1sUCgrUTOpGhj7eVP5hJhprWhrR6nWr7MOHHG/J3WfCZ3D06BElXQgSdvie9yj/h0Ptyjug/6uG0Jd0bYEULwRL1t3FQI8/+fuio9/IKyjZl5B5D1NDXw+BN/ic/zhh+GJXhkl+kgLtt6SPk0YvIfYXWhhBdO/1haDbU2X5BrP4pQ9l585D0T0QcoZ6MV53H+2FJen5GluqIjQ2drXVIYF870IVc50/pGNp2WJGyEQcl25A0z48oOJM5fQdq9j0RKbs4lW/J1H+oL9ovzwamcYHsA3exFFPeCVRJhbhLejxMDqRM3P7eNY7ES6f8hpOc681VcdxTsqTmmMLQl4ytMV6uDrgh5iJq0WjcHFqlCgQtakJEc9le/ZLtUrqv9H/56KQTPAlnuOPqhbdgWlJ/C7w4/qFK6I65IwxzSK0MdkEBNCZbaIUhvCdENWP0XZrqJS+tS3yNQJTiBGdzAabquFF4M= test@Netology"
}


# Task 5
variable "in_the_end_there_can_be_only_string" {
  description = "Who is better Connor or Duncan?"
  type        = string

  # default = "Who is better Connor or Duncan?"
  default = "who is better connor or duncan?"

  validation {
    error_message = "There can be only one MacLeod"
    condition     = can(regex("^[^A-Z]+$", var.in_the_end_there_can_be_only_string))
  }
}

variable "in_the_end_there_can_be_only_object" {
  description = "Who is better Connor or Duncan?"
  type = object({
    Dunkan = optional(bool)
    Connor = optional(bool)
  })

  default = {
    Dunkan = true
    Connor = false
  }

  validation {
    error_message = "There can be only one MacLeod"
    condition     = (var.in_the_end_there_can_be_only_object.Dunkan == true && var.in_the_end_there_can_be_only_object.Connor == false) || (var.in_the_end_there_can_be_only_object.Dunkan == false && var.in_the_end_there_can_be_only_object.Connor == true)
  }
}
