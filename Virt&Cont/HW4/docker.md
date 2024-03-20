# Практическое применение Docker
# Домашнее задание к занятию 5. «Практическое применение Docker»

## Задача 0.
1. Docker-compose не установлен.
2. Версия docker compose 2.24.7.

## Задача 1.   
1. Сделал fork репозитория https://github.com/netology-code/shvirtd-example-python/blob/main/README.md
2. Создал файлы Dockerfile.python и .dockerignore.

## Задача 3.
1. Изучил файл "proxy.yaml".
2. Создал файл "compose.yaml" и включил туда файл "proxy.yaml".
3. В файле "compose.yaml" описал сервисы web, собранный из образа Dockerfile.python, и db.
4. Запустил проект командой "docker compose up -d", запустил команду "curl -L http://127.0.0.1:8090" и увидел ответ в консоли.

![curl](https://github.com/Adel-pro/Netology/assets/116494871/f659470e-aa90-4dcf-a9ae-f277eb5cb4bf)


5. Подключился к БД mysql командой "docker exec -it shvirtd-example-python-main-db-1 mysql -uroot -p" c паролем, указанным в переменной MYSQL_ROOT_PASSWORD. Ввел команды:
   show databases;
   use virtd;
   show tables;
   SELECT * from requests LIMIT 10;

![mysql1](https://github.com/Adel-pro/Netology/assets/116494871/830a5a35-60a6-4055-a351-a6273666f11a)

6. Остановил проект командой "docker compose down -v".

## Задача 4.
1. Запустил в Yandex Cloud ВМ с операционкой ubuntu 22.04.  
2. Подключился к ВМ по ssh и установил docker (https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-22-04).  
3. Написал bash-скрипт в ВМ, который устанавливает git, скачивает fork репозиторий (https://github.com/Adel-pro/shvirtd-example-python) в каталог /opt и запускает проект.  
4. Зашел на https://check-host.net/check-http, ввел http://62.84.122.242:8090 и запустил проверку сервиса.  
6. Повторил sql-запрос.

![mysql2](https://github.com/Adel-pro/Netology/assets/116494871/cca18959-5fdd-4eff-89db-83cadc28ebe7)


## Задача 6.
Скачал образ hashicorp/terraform:latest. Для скачивания файла /bin/terraform на локальную машину, использовал следующие команды:  
docker run -rm -it -v /var/run/docker.sock:/var/run/docker.sock wagoodman/dive:latest  hashicorp/terraform:latest  
docker save hashicorp/terraform:latest -o image.tar  
tar -xf image.tar  
cd blobs/sha256
cat b22c6fe345f979d4956c9570f757a0d13f1d7abf0b26121f3adfed2cf580c055

![dive](https://github.com/Adel-pro/Netology/assets/116494871/2c4026d4-5fc0-4a8c-a75a-4f5dcb3bffa5)


## Задача 6.1.
Также, получил доступ к бинарному файлу /bin/terraform с помощью следующих команд:  
docker run --name test hashicorp/terraform:latest  
docker cp test:/bin/terraform .
