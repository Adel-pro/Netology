# # Task 1-3
# # module "marketing" {
# #   source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
# #   env_name       = module.vpc_dev.vpc_subnet.name
# #   network_id     = module.vpc_dev.vpc_subnet.network_id
# #   subnet_zones   = [module.vpc_dev.vpc_subnet.zone]
# #   subnet_ids     = [module.vpc_dev.vpc_subnet.id]
# #   instance_name  = "web1"
# #   instance_count = 1
# #   image_family   = var.vm_image
# #   public_ip      = true
# #   labels = {
# #     project = "marketing"
# #   }

# #   metadata = {
# #     user-data          = data.template_file.cloudinit.rendered
# #     serial-port-enable = 1
# #   }

# # }

# # module "analytics" {
# #   source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
# #   env_name       = module.vpc_dev.vpc_subnet.name
# #   network_id     = module.vpc_dev.vpc_subnet.network_id
# #   subnet_zones   = [module.vpc_dev.vpc_subnet.zone]
# #   subnet_ids     = [module.vpc_dev.vpc_subnet.id]
# #   instance_name  = "web2"
# #   instance_count = 1
# #   image_family   = var.vm_image
# #   public_ip      = true
# #   labels = {
# #     project = "analytics"
# #   }

# #   metadata = {
# #     user-data          = data.template_file.cloudinit.rendered
# #     serial-port-enable = 1
# #   }

# # }

# data "template_file" "cloudinit" {
#   template = file("./cloud-init.yml")

#   vars = {
#     ssh_public_key = var.ssh_public_key
#   }
# }


# # module "vpc_dev" {
# #   source         = "./vpc"
# #   name           = "develop"
# #   zone           = "ru-central1-a"
# #   v4_cidr_blocks = ["10.0.1.0/24"]
# #   token          = var.token
# #   cloud_id       = var.cloud_id
# #   folder_id      = var.folder_id
# # }

# # Task 4
# module "marketing" {
#   source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
#   env_name       = module.vpc_dev.vpc_subnet["ru-central1-a"].name
#   network_id     = module.vpc_dev.vpc_subnet["ru-central1-a"].network_id
#   subnet_zones   = [module.vpc_dev.vpc_subnet["ru-central1-a"].zone]
#   subnet_ids     = [module.vpc_dev.vpc_subnet["ru-central1-a"].id]
#   instance_name  = "web1"
#   instance_count = 1
#   image_family   = var.vm_image
#   public_ip      = true
#   labels = {
#     project = "marketing"
#   }

#   metadata = {
#     user-data          = data.template_file.cloudinit.rendered
#     serial-port-enable = 1
#   }

# }

# module "analytics" {
#   source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
#   env_name       = module.vpc_dev.vpc_subnet["ru-central1-a"].name
#   network_id     = module.vpc_dev.vpc_subnet["ru-central1-a"].network_id
#   subnet_zones   = [module.vpc_dev.vpc_subnet["ru-central1-a"].zone]
#   subnet_ids     = [module.vpc_dev.vpc_subnet["ru-central1-a"].id]
#   instance_name  = "web2"
#   instance_count = 1
#   image_family   = var.vm_image
#   public_ip      = true
#   labels = {
#     project = "analytics"
#   }

#   metadata = {
#     user-data          = data.template_file.cloudinit.rendered
#     serial-port-enable = 1
#   }

# }

module "vpc_dev" {
  source = "./vpc"
  name   = "develop"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
    { zone = "ru-central1-c", cidr = "10.0.3.0/24" },
  ]
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
}


# # Task 5 
# module "mysql" {
#   source          = "./mysql"
#   name            = "example"
#   zone1           = module.vpc_dev.vpc_subnet["ru-central1-a"].zone
#   zone2           = module.vpc_dev.vpc_subnet["ru-central1-b"].zone
#   network_id      = module.vpc_dev.vpc_subnet["ru-central1-a"].network_id
#   subnet_id1      = module.vpc_dev.vpc_subnet["ru-central1-a"].id
#   subnet_id2      = module.vpc_dev.vpc_subnet["ru-central1-b"].id
#   v4_cidr_blocks1 = module.vpc_dev.vpc_subnet["ru-central1-a"].v4_cidr_blocks
#   v4_cidr_blocks2 = module.vpc_dev.vpc_subnet["ru-central1-b"].v4_cidr_blocks
#   token           = var.token
#   cloud_id        = var.cloud_id
#   folder_id       = var.folder_id
# }

# module "database" {
#   source    = "./database"
#   id        = module.mysql.mysql_name
#   name      = module.mysql.mysql_network_id
#   zone1     = module.vpc_dev.vpc_subnet["ru-central1-a"].zone
#   username  = "app"
#   password  = var.password
#   token     = var.token
#   cloud_id  = var.cloud_id
#   folder_id = var.folder_id
# }

# Task 6
resource "random_string" "unique_id" {
  length  = 8
  upper   = false
  lower   = true
  numeric = true
  special = false
}

module "s3" {
  source = "./simple-bucket"

  bucket_name = "simple-bucket-${random_string.unique_id.result}"
  token       = var.token
  cloud_id    = var.cloud_id
  folder_id   = var.folder_id
  max_size    = 1073741824
}
