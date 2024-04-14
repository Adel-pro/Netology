# Использование Terraform в команде
# Домашнее задание к занятию «Использование Terraform в команде»

## Чек-лист готовности к домашнему заданию
  1. Аккаунт в Yandex Cloud есть, промокод активирован.
  2. Утилита ус установлена.
  3. Используются прерываемые ВМ и после каждого перерыва/домашнего задания удаляются.
  4. Версия Terraform = 1.5.4.
      
## Задание 0
  1. Статья https://neprivet.com/ прочитана.
  2. Буду распространять.

## Задание 1
  1. Взял код из предыдущей лекции.
  2. Проверил код с помощью tflint. Для этого создал файл .tflint.hcl в той же папке, что и terraform-код, с содержимым:  
     ![1](https://github.com/Adel-pro/Netology/assets/116494871/7f579810-be25-4543-bb83-aeaf9709fa8a)  
     Далее, командой "docker run --rm -v $(pwd):/data -t ghcr.io/terraform-linters/tflint" поднял контейнер и получил следующую ошибку:  

     Failed to load configurations; main.tf:30,1-20: "example-vm" module is not found. Did you run "terraform init"?; , and 1 other diagnostic(s):  

     Error: "example-vm" module is not found. Did you run "terraform init"?  
       on main.tf line 30, in module "example-vm":  
       30: module "example-vm" {  
    
     Error: "test-vm" module is not found. Did you run "terraform init"?  
       on main.tf line 12, in module "test-vm":  
       12: module "test-vm" {  

     Проверил код с помощью checkov. Для этого скачал образ командой "docker pull bridgecrew/checkov" и запустил его командой "docker run --rm --tty --volume $(pwd):/tf --workdir /tf bridgecrew/checkov --download-external-modules true --directory /tf".  
      By Prisma Cloud | version: 3.2.60  
      terraform scan results:  
      Passed checks: 2, Failed checks: 6, Skipped checks: 0  

      Check: CKV_YC_4: "Ensure compute instance does not have serial console enabled."  
              PASSED for resource: module.example-vm.yandex_compute_instance.vm[0]  
              File: /.external_modules/github.com/udjin10/yandex_compute_instance/main/main.tf:24-73  
              Calling File: /main.tf:30-46  
      Check: CKV_YC_4: "Ensure compute instance does not have serial console enabled."  
              PASSED for resource: module.test-vm.yandex_compute_instance.vm[0]  
              File: /.external_modules/github.com/udjin10/yandex_compute_instance/main/main.tf:24-73  
              Calling File: /main.tf:12-28  

     Check: CKV_YC_2: "Ensure compute instance does not have public IP."  
              FAILED for resource: module.example-vm.yandex_compute_instance.vm[0]  
              File: /.external_modules/github.com/udjin10/yandex_compute_instance/main/main.tf:24-73  
              Calling File: /main.tf:30-46  
      
      Check: CKV_YC_11: "Ensure security group is assigned to network interface."  
              FAILED for resource: module.example-vm.yandex_compute_instance.vm[0]  
              File: /.external_modules/github.com/udjin10/yandex_compute_instance/main/main.tf:24-73  
              Calling File: /main.tf:30-46  
      
      Check: CKV_YC_2: "Ensure compute instance does not have public IP."  
              FAILED for resource: module.test-vm.yandex_compute_instance.vm[0]  
              File: /.external_modules/github.com/udjin10/yandex_compute_instance/main/main.tf:24-73  
              Calling File: /main.tf:12-28  
      
      Check: CKV_YC_11: "Ensure security group is assigned to network interface."  
              FAILED for resource: module.test-vm.yandex_compute_instance.vm[0]  
              File: /.external_modules/github.com/udjin10/yandex_compute_instance/main/main.tf:24-73  
              Calling File: /main.tf:12-28  

      Check: CKV_TF_1: "Ensure Terraform module sources use a commit hash"  
              FAILED for resource: test-vm  
              File: /main.tf:12-28  
              Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/supply-chain-policies/terraform-policies/ensure-terraform-module-sources-use-git-url-with-commit-hash-revision  
      
                      12 | module "test-vm" {  
                      13 |   source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"  
                      14 |   env_name       = "develop"  
                      15 |   network_id     = yandex_vpc_network.develop.id  
                      16 |   subnet_zones   = ["ru-central1-a"]  
                      17 |   subnet_ids     = [yandex_vpc_subnet.develop.id]  
                      18 |   instance_name  = "web"  
                      19 |   instance_count = 1  
                      20 |   image_family   = "ubuntu-2004-lts"  
                      21 |   public_ip      = true  
                      22 |   
                      23 |   metadata = {  
                      24 |     user-data          =   data.template_file.cloudinit.rendered #Для демонстрации №3  
                      25 |     serial-port-enable = 1  
                      26 |   }  
                      27 |   
                      28 | }  
      
      Check: CKV_TF_1: "Ensure Terraform module sources use a commit hash"  
              FAILED for resource: example-vm  
              File: /main.tf:30-46  
              Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/supply-chain-policies/terraform-policies/ensure-terraform-module-sources-use-git-url-with-commit-hash-revision  
      
                      30 | module "example-vm" {   
                      31 |   source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"  
                      32 |   env_name       = "stage"  
                      33 |   network_id     = yandex_vpc_network.develop.id  
                      34 |   subnet_zones   = ["ru-central1-a"]  
                      35 |   subnet_ids     = [yandex_vpc_subnet.develop.id]  
                      36 |   instance_name  = "web-stage"  
                      37 |   instance_count = 1  
                      38 |   image_family   = "ubuntu-2004-lts"  
                      39 |   public_ip      = true  
                      40 |   
                      41 |   metadata = {  
                      42 |     user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3  
                      43 |     serial-port-enable = 1  
                      44 |   }  
                      45 |   
                      46 | }  
  3. В tflint получил ошибку типа "module is not found" (после инициализации эти ошибки ушли). В checkov получил ошибки типа "Ensure compute instance does not have public IP", "Ensure security group is assigned to network interface" и "Ensure Terraform module sources use a commit hash".

## Задание 2
  1. Взял все файлы из HW4 и создал директорию в HW5 с названием "terraform-05".
  2. Создал сервисный аккаунт "storage" и дал нужные права.  
     ![2](https://github.com/Adel-pro/Netology/assets/116494871/857dea6f-f0d8-4831-9c30-f36fbd4a3b13)  
     Создал статический ключ доступа.  
     ![4](https://github.com/Adel-pro/Netology/assets/116494871/7993ecd2-d892-4053-a66c-9687c424f86d)  
     Создал S3 bucket "my-tfstate" и добавил пользователя "storage" с правами read and write.  
     ![3](https://github.com/Adel-pro/Netology/assets/116494871/b814c9cc-34b8-45f3-92e1-fd1e26511574)  
     Создал YDB "tflock-test" и таблицу в нем "tfstate-test".  
     ![6](https://github.com/Adel-pro/Netology/assets/116494871/3658c5e6-4c6f-41c7-82db-06d5847edcf9)  
     Проверил вначале с S3 bucket.  
     ![5](https://github.com/Adel-pro/Netology/assets/116494871/4ae6d35c-fa7b-471c-9ad6-d06a0af1f645)  
     Далее, проверил с YDB.  
     ![7](https://github.com/Adel-pro/Netology/assets/116494871/2430f725-d178-40be-bfbd-18b7fa0362da)
  3. Закоммитил в "terraform-05".
  4. Открыл в одном терминале terraform console, в другом - terraform apply.     5.
  5. Получил ошибку.  
     ![8](https://github.com/Adel-pro/Netology/assets/116494871/1d8638b1-935c-4010-8c11-c4a9f6cd9a32)
  6. Принудительно разблокировал state командой "terraform force-unlock e2f0b9f3-0927-6776-0068-681f3f82bc2f".  
     ![9](https://github.com/Adel-pro/Netology/assets/116494871/1f70df82-d93a-4eb5-912f-3c9abb7090f9)


## Задание 3
  1. Сделал новую ветку "terraform-hotfix".
  2. Проверил код с помощью tflint.  
     ![10](https://github.com/Adel-pro/Netology/assets/116494871/77314f41-ee03-4d10-9d2d-7395072a6283)  
     Исправил почти все ошибки. Запустив checkov, увидел предупреждение Check: CKV_YC_1: "Ensure security group is assigned to database cluster." для модуля mysql.
  3. Создал pull request 'terraform-hotfix' --> 'terraform-05'.
  4. Вставил в комментарий результат проверок tflint и checkov, а также вывод команды "terraform plan".
  5. Ссылка на PR: https://github.com/Adel-pro/Netology/pull/1/commits/ef45154826b6e360a2d6c2b2712a6c3af62a6f2b

## Задание 4
  1. Написал переменную с type=string в terraform console.  
     ![11](https://github.com/Adel-pro/Netology/assets/116494871/290ecdf9-6823-42a0-93ca-fcb4d7a2c787)  
     Написал переменную с type=list(string) в terraform console. Полностью выражение c regex написать не удалось, только через цикл.  
     ![12](https://github.com/Adel-pro/Netology/assets/116494871/cdae874e-0df2-43a7-ac3a-f4e5604ec3ae)

## Задание 5
  1. Написал переменные с валидацией с type=string и type=object.  
      variable "in_the_end_there_can_be_only_string" {  
        description = "Who is better Connor or Duncan?"  
        type        = string  
       
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
