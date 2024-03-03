# Введение в Terraform
# Домашнее задание к занятию «Введение в Terraform»

## Чек-лист готовности к домашнему заданию.
  На Windows-хосте в VirtualBox создал ВМ с ubuntu 20.04 и выполнил следующие задачи:  
  1. Установил Terraform (https://hashicorp-releases.yandexcloud.net/terraform/)  
     Посмотрел версию и приложил скрин "".  
  2. Скачал git, загрузил нужный git-репозиторий  
  3. Установил docker  
  4. Зарегистрировался в https://hub.docker.com/  
      
## Задача 1.
  1. Скачал все зависимости для проекта командой "terraform init"  
     Вызвало затруднение сохранение файла .terraformrc в папку /home/user/. Когда сохранил и начал выполнение команды, опять получил эту же ошибку. Открыл новое окно терминала, перестал ругаться на провайдера, но получил ошибку о permission denied. Начал выполнять команду под rootом, опять вернулся к изначальной ошибке, которую получал до сохранения файла terraformrc в папку /home/user/. Пришлось закинуть файл в папку /root, тогда под rootом команда выполнилась.  
  2. Согласно файлу .gitignore, допустимо хранить личную и секретную информацию в файле personal.auto.tfvars. Помимо этого файла, игнорируются файлы, начинающиеся с .terraform (кроме файла .terraformrc) и файлы, заканчивающиеся на .tfstate и содержащие в названии .tfstate.. В этих файлах хранятся секретные данные инфраструктуры, поэтому их можно  оставить. Также, секретную информацию можно хранить в каталоге .terraform.
  3. Выполнил код проекта командой "terraform apply". Пароль сгенерировался следующий:  
     "result": "qSfebYT22BZFo3O5"
  4. Заметил следующие ошибки при валидации:
     - line 24, All resource blocks must have 2 labels (type, name). Добавил необходимый исходя из кода ниже название блоку resource.
     - line 29, A name must start with a letter or underscore and may contain only letters, digits, underscores, and dashes. Убрал единичку с названия имени блока resource.
     - on main.tf line 31, A managed resource "random_password" "random_string_FAKE" has not been declared in the root module. Убрал ненужные символы, так как в названии блока resource с паролем, расположенном выше, их не было.
   5. Выполнил код с комощью команды "terraform apply". Вывод "docker ps":
      CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS                  NAMES
59ead9b0c495   e4720093a3c1   "/docker-entrypoint.…"   5 seconds ago   Up 4 seconds   0.0.0.0:9090->80/tcp   example_qSfebYT22BZFo3O5
   6. Вывод команды "docker ps":
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS                  NAMES
822fe19bca7c   e4720093a3c1   "/docker-entrypoint.…"   7 seconds ago   Up 6 seconds   0.0.0.0:9090->80/tcp   example_qSfebYT22BZFo3O5  
      Опция -auto-approve позволяет убрать интерактивные вопросы, связанные с изменениями конфигурации файла, для подтверждения внесения этих изменений (как например, Enter a value: yes). Удобная опция для выполнения тестирования, но не в среде продакшн, так как автоматические изменения без одобрения инженера могут повлечь за собой неприятные последствия, придется откатывать.  
   7. Уничтожил ресурсы командой "terraform destroy".  
   8. Согласно документации https://docs.comcloud.xyz/providers/kreuzwerker/docker/latest/docs/resources/image, для автоматического удаления образа надо применить аргумент force_remove. В нашем случае будет  
      resource "docker_image" "nginx" {
        name         = "nginx:latest"
        keep_locally = true
        force_remove = true
      }
 

## Задача 2.
На данный момент содержимое файла main.tf выглядит так:  
terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.13" 
}
provider "yandex" {
  zone = "ru-central1-b"
}


resource "random_root_password" "random_string" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

resource "random_password" "random_string" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}


resource "yandex_compute_instance" "vm-1" {
  name = "test"

  connection {
    host = "158.160.12.212"
    user = "test"
    type = "ssh"
    private_key = "${file("~/.ssh/id_rsa.pub")}"
    timeout = "1m"
    agent = true
  }

  resource "docker_container" "db-sever1" {
    name = "db-server"
    provisioner "remote-exec" {
      command = [
        "sudo docker run --name mysql \
           -e "MYSQL_ROOT_PASSWORD=${random_root_password.random_string.result}" \
           -e MYSQL_DATABASE=wordpress \
           -e MYSQL_USER=wordpress \
           -e "MYSQL_PASSWORD=${random_password.random_string.result}" \
           -e MYSQL_ROOT_HOST="%" \
           -p 3306:3306 -d mysql:8"
      ]
    }
  }
}


Получаю ошибку при выполнении команды "terraform validate":  
Error: Invalid character
│ 
│   on main.tf line 47, in resource "yandex_compute_instance" "vm-1":
│   47:         "sudo docker run --name mysql \
│ 
│ This character is not used within the language.
