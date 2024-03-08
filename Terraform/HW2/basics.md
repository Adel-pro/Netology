# Основы работы с Terraform
# Домашнее задание "Основы работы с Terraform"

## Чек-лист готовности к домашнему заданию
  1. Зарегистрировался в Yandex Cloud, промокод активировал.  
  2. Утилиту ус установил.  
  3. Код для задания из репозитория скачен.  
      
## Задача 1.
  1. Просмотрел проект и файл variables.tf.  
  2. Создал сервисный аккаунт и авторизованный ключ.  
     Пытался создать доступ к сервисному аккаунту через iam в CLI. Постоянно ругался на permission denied. В итоге создал авторизованный ключ через веб-интерфейс yandex cloud, заработало. В дальнейшем, буду пытаться создавать ключи через cli, вдруг пригодится...   
  3. Создал отдельную переменную vms_ssh_public_root_key, куда поместил путь до публичного ключа.  
  4. Выполнил команды "terraform init" и "terraform apply". Были ошибки, связанные с неподходящими настройками для создания ВМ, а именно cores (минимальное значение 2), core_fraction (может принимать значения только 5, 20, 50 и 100) и platform (https://cloud.yandex.ru/ru/docs/compute/concepts/vm-platforms).  
  5. Подключился к ВМ через ssh, выполнил команду "curl ifconfig.me", приложил скрин "curl.png". Сделал скрин в ЛК yandex cloud с внешним ip "vm_yandex_cloud.png".  
     Проблема заключалась в том, что при подключении к ВМ по ssh требовался пароль. Менял методы прокидывания публичного ключа (ssh-keys, user-data), пробовал использовать пару ключей от пользователя, потом от рута (ну вдруг). В итоге решилось после 8го задания, после того, как убил машины (terraform destroy), закрыл все задачи в терминале, сделал все заново.  
  6. Прерываемая машина (preemptible = true) отключается через 24 часа (может и раньше, так как они могут быть отозваны в любой момент). Низкий уровень производительности можно добиться с помощью core_fraction=5. Применяя эти параметры, можно сократить затраты на ВМ, поэтому они могут сильно пригодиться в обучении.  

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
  1. Создал файл "vms_platform.tf", поместил нужные переменные.  
  2. Создал вторую ВМ с названием "netology-develop-platform-db", нужные переменные подставил.  
     Заключалась сложность в решении проблемы использования одной подсети в разных зонах. В итоге, создал в разных подсетях. Также, потратил немного времени, чтобы сетки были в одной VPC.   
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
     Позже понял, что можно было и так: type = map(string).  
  3. Использовал переменные в файле main.tf.  
  4. Применил команду "terraform plan", изменений не произошло.  
     Примечание: создал map-переменные в файле variables.tf. В ходе 8го задания понял, как поместить их в файл terraform.tfvars.  

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
     Значение самой переменной положил в файл terraform.tfvars. Применил "terraform plan", ничего не поменялось.  
  2. Для вывода строки "ssh -o 'StrictHostKeyChecking=no' ubuntu@62.84.124.117" вызвал команду:  
     var.test[0].dev1[0]  

## Задача 9. 
  1. Зашел в ВМ через ssh, поменял пароль командой "sudo passwd ubuntu".  
  2. Убрал внешний ip, перевев nat в значение false  
  3. Подключился к serial console, попинговал ya.ru, не пингуется.  
