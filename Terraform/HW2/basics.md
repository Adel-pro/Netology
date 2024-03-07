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
