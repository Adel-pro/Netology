# Введение в Terraform
# Домашнее задание к занятию «Введение в Terraform»

## Чек-лист готовности к домашнему заданию.
  На Windows-хосте в VirtualBox создал ВМ с ubuntu 20.04 и выполнил следующие задачи:  
  1. Установил Terraform (https://hashicorp-releases.yandexcloud.net/terraform/)  
     Посмотрел версию и приложил скрин "TF_version.png".  
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
      Опция -auto-approve позволяет убрать интерактивные вопросы, связанные с изменениями конфигурации файла, для подтверждения внесения этих изменений (как например, Enter a value: yes). Удобная опция для выполнения тестирования, но не в среде продакшн, так как автоматические изменения без одобрения инженера могут повлечь за собой неприятные последствия. Возможно, придется откатывать, если система откатов работает.  
   7. Уничтожил ресурсы командой "terraform destroy".  
   8. Согласно документации https://docs.comcloud.xyz/providers/kreuzwerker/docker/latest/docs/resources/image, для автоматического удаления образа надо применить аргумент force_remove. В нашем случае будет  
      resource "docker_image" "nginx" {  
        name         = "nginx:latest"  
        keep_locally = true  
        force_remove = true  
      }  
 

## Задача 2.
  1. Создал ВМ в yandex cloud.  
  2. Подключился по ssh, установил docker.  
  3. Нашел в документации, как работать с docker на удаленной машине (https://docs.comcloud.xyz/providers/kreuzwerker/docker/latest/docs)  
  4. Создал файл main.tf в другой директории и изменил ее содержимое для запуска mysql в контейнере.  
  5. Зашел на ВМ, проверил контейнер, зашел в него и проверил переменные среды.  

Содержимое файла main.tf выглядит так:  
terraform {  
  required_providers {  
    docker = {  
      source  = "kreuzwerker/docker"  
      version = "~> 3.0.1"  
    }  
  }  
  required_version = ">=0.13"   
}  

provider "docker" {  
  host     = "ssh://test@51.250.97.31:22"  
  ssh_opts = ["-o", "StrictHostKeyChecking=no", "-o", "UserKnownHostsFile=/home/test/.ssh/known_hosts"]  
}  


resource "random_password" "random_root_string" {  
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

resource "docker_container" "mysql" {  
  name = "mysql"  
  image = "mysql:8"  

  ports {  
    internal = "3306"  
    external = "3306"  
  }  

  env = ["MYSQL_ROOT_PASSWORD=${random_password.random_root_string.result}",  
         "MYSQL_DATABASE=wordpress",  
         "MYSQL_USER=wordpress",  
         "MYSQL_PASSWORD=${random_password.random_string.result}",  
         "MYSQL_ROOT_HOST='%'"  
        ]  
}  

Переменные среды в контейнере:  
MYSQL_PASSWORD=b4mW8KV3GauNiDmo  
HOSTNAME=76c1bbb7a272  
MYSQL_DATABASE=wordpress  
MYSQL_ROOT_PASSWORD=eZA0Cik0LfZxyRAQ  
PWD=/  
HOME=/root  
MYSQL_MAJOR=innovation  
GOSU_VERSION=1.16  
MYSQL_USER=wordpress  
MYSQL_VERSION=8.3.0-1.el8  
TERM=xterm  
SHLVL=1  
MYSQL_ROOT_HOST='%'  
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin  
MYSQL_SHELL_VERSION=8.3.0-1.el8  
_=/usr/bin/env  

С какими проблемами столкнулся:
  - долго находил реализацию подключения к docker на удаленной ВМ через terraform. Пробовал через connection, provisioner и прочее, пока не нашел ssh://.
  - terafform не мог подключиться к docker engine. Не сразу понял, что причина была в том, что команды docker работали через sudo. Дал привилегии докеру командами "sudo groupadd -f docker", "sudo usermod -aG docker $USER", перезагрузил машину и демон "sudo service docker start", заработало.
