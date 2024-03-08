# Основы работы с Terraform
# Домашнее задание "Основы работы с Terraform"

## Чек-лист готовности к домашнему заданию
  1. Зарегистрировался в Yandex Cloud, промокод активировал. 
  2. Утилиту ус установил. 
  3. Код для задания из репозитория скачен. 
      
## Задача 1.
  1. Просмотрел проект и файл variables.tf
  2. Создал сервисный аккаунт и авторизованный ключ.
  3. Создал отдельную переменную vms_ssh_public_root_key, куда поместил путь до публичного ключа.
  4. Выполнил команды "terraform init" и "terraform apply". Исправил ошибки.

## Задача 2.
  1. Объявил переменные vm_web_image, vm_web_name и vm_web_platform для параметров family, name и platform_id соответственно.
  2. В файл variables.tf следующие переменные:
     variable "vm_web_image" {
       type        = string
       default     = "ubuntu-2004-lts"
       description = "VM image" 
     }

     variable "vm_web_name" {
       type        = string
       default     = "netology-develop-platform-web"
       description = "Platform name"
     }

     variable "vm_web_platform" {
       type        = string
       default     = "standard-v3"
       description = "Platform"
     }
  3. После применения "terraform plan" получил сообщение:
     No changes. Your infrastructure matches the configuration.

## Задача 3.  
  1. Создал файл 'vms_platform.tf', поместил нужные переменные.
  2. Создал вторую ВМ с названием "netology-develop-platform-db", нужные переменные подставил.
  3. Применил изменения командой "terraform apply".

## Задача 4.
  1. Объявил один output для каждой ВМ, включив информацию об instance_name, external_ip, fqdn.
  2. Применил команду "terraform apply". Приложил скрин "outputs.png".

## Задача 5.
  1. Создал local-блок с локальными переменными для имен ВМ, использовав интерполяцию.
  2. Заменил в root модуле имена ВМ на local-переменные.
  3. Применил команду "terraform apply", изменений не произошло.

## Задача 6.    
  1. В файле variables.tf создал map-переменную vms_resources, в которой объявил 3 переменные (cores, memory, core_fraction):
     variable "vms_resources" {
         type = map(any)
         default = {
             web = {
                 cores = "2"
                 memory = "1"
                 core_fraction = "20"
             },
             db = {
                 cores = "2"
                 memory = "2"
                 core_fraction = "20"
             }
         }
     }
  2. В этом же файле создал переменную для блока metadata:  
     variable "metadata" {
         type = object({serial-port-enable = number, ssh-keys = string})
         default = {
             serial-port-enable = 1,
             ssh-keys           = "ubuntu:ssh-rsa AAAAB ..."
         }
     }
  3. Использовал переменные в файле main.tf.
  4. Применил команду "terraform plan", изменений не произошло.

## Задача 7.
  1. local.test_list[1]
     "staging"
  2. length(local.test_list)
     3
  3. local.test_map["admin"]
     "John"
  4. "${ local.test_map["admin"] } is keys(local.test_map)[0] for ${ local.test_list[2] } server based on OS ${ local.servers["production"]["image"] } with ${ local.servers["production"]["cpu"] } vcpu, ${ local.servers["production"]["ram"] } ram and ${ length(local.servers["production"]["disks"]) } virtual disks"
     "John is admin for production server based on OS ubuntu-20-04 with 10 vcpu, 40 ram and 4 virtual disks"

## Задача 8.
  1. Создал переменную test в файле variables.tf:
     variable "test" {
       type = list(map(list(string)))
     }
     Значение самой переменной положил в файл terraform.tfvars. Применил "terraform plan",  
  3. var.test[0].dev1[0]
