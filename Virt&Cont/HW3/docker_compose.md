# Введение в Docker
# Домашнее задание по занятию "Оркестрация группой Docker контейнеров на примере Docker Compose."

## Задача 1.
  1. На Windows-хосте в VirtualBox создал ВМ с ubuntu 20.04 и установил docker и docker compose plugin.  
  2. Создал публичный репозиторий "custom-nginx" на https://hub.docker.com.  
  3. Скачал образ командой "docker pull nginx:1.21.1".  
  4. Создал Dockerfile для замены файла index.html.  
  5. Собрал образ командой "docker build -t adel123adel/custom-nginx:1.0.0 .".  Авторизовался с помощью команды "docker login -u adel123adel" и отправил в dockerhub-репозиторий командой "docker push adel123adel/custom-nginx:1.0.0".  
  6. Ссылка на публичный репозиторий: https://hub.docker.com/repository/docker/adel123adel/custom-nginx/general  

## Задача 2.
  1. Запустил образ командой "docker run --name RAF-custom-nginx-t2 -d -p 127.0.0.1:8080:80 adel123adel/custom-nginx:1.0.0".  
  2. Переименовал контейнер командой "docker rename RAF-custom-nginx-t2 custom-nginx-t2".  
  3. Выполнил команды: date +"%d-%m-%Y %T.%N %Z" ; sleep 0.150 ; docker ps ; ss -tlpn | grep 127.0.0.1:8080  ; docker logs custom-nginx-t2 -n1 ; docker exec -it custom-nginx-t2 base64 /usr/share/nginx/html/index.html  
  4. С помощью "curl http://127.0.0.1:8080" убедился, что страница доступна (скрин curl.png).  

## Задача 3.
  1. Подключился к контейнеру командой "docker attach custom-nginx-t2".  
  2. Вышел со стандартного потока ввода/вывода/ошибок контейнера, нажав Ctrl-C.  
  3. Контейнер остановился, потому что после нажатия Ctrl-C прервались все процессы в контейнере (контейнер жив пока жив запущенный в нем процесс).  
  4. Перезапустил контейнер командой "docker start custom-nginx-t2".  
  5. Зашел в терминал контейнера командой "docker exec -it custom-nginx-t2 bash".  
  6. Установил редактор nano командами "apt update" и "apt-get install nano".  
  7. Отредактировал файл "/etc/nginx/conf.d/default.conf", заменив порт "listen 80" на "listen 81".  
  8. Перезагрузил nginx командой "nginx -s reload" и убедился, что на команду "curl http://127.0.0.1:80" отклика нет, а на "curl http://127.0.0.1:81" - есть.  
  9. Вышел из контейнера, нажав Ctrl-D.  
  10. Выполнил команды:  
      ss -tlpn | grep 127.0.0.1:8080  
      docker port custom-nginx-t2  
      curl http://127.0.0.1:8080.  
      Увидел, что проброс портов перестал работать, так как со стороны контейнера указан порт 80, а не 81.  
  12. Поправил ситуацию командами:  
      sudo docker stop custom-nginx-t2  
      docker commit custom-nginx-t2 custom-nginx-t2-image    
      docker run --name custom-nginx-t2-v2 -d -p 127.0.0.1:8080:81 -td custom-nginx-t2-image  
  13. Удалил контейнер командой "docker rm custom-nginx-t2 -f" (скрин docker_rm.png).  

## Задача 4.
  1. Запустил новый контейнер командой "docker run -d -it -v $(pwd):/data centos:7 bash".  
  2. Запустил другой контейнер командой "docker run -d -it -v $(pwd):/data debian:11 bash".  
  3. Подключился к контейнеру с образом centos командой "docker exec -it mystifying_leakey bash", скачал редактор nano "yum install nano" и создал файл some_file.txt. Вышел из контейнера и проверил наличие файла на хост-машине (скрин host_file.png).  
  4. Добавил в рабочем каталоге на хостовой машине файл host_file.  
  5. Подключился к контейнеру с образом debian командой "docker exec -it wizardly_varahamihira bash", убедился, что файл host_file есть (скрин container_file.png).  

## Задача 5.
  1. В отдельной директории создал 2 файла с названием "compose.yaml" и "docker-compose.yaml". Выполнил команду "docker compose up -d". Был запущен файл "compose.yaml", так как это путь по умолчанию для компоуз файла, т.е. он в первую очередь смотрит на этот файл, потом уже на другие.  
  2. Включил в файл "compose.yaml" содержимое файла "docker-compose.yaml".  
  3. Чтобы залить образ в локальное registry, выполнил следующие команды:  
     docker tag adel123adel/custom-nginx:1.0.0 custom-nginx:latest  
     docker push localhost:5000/custom-nginx:latest  
  4. Открыл страницу "http://127.0.0.1:9000" и произвел начальную настройку.  
     Сложность заключалась в том, что ни при http, ни при https не работало. Добавил в "compose.yaml" строчку "command: -H unix:///var/run/docker.sock --no-auth --ssl", заработало.  
  5. В локальном окружении задеплоил компоуз.  
  6. На странице "http://127.0.0.1:9000/#!/1/docker/containers" выбрал контейнер с nginx и посмотрел inspect (скрин portainer_inspect.png).  
  7. Удалил в файле манифест, связанный с registry, выполнил команду "docker compose up -d" и вышло предупреждение:  
     WARN[0000] Found orphan containers ([task5-registry-1]) for this project. If you removed or renamed this service in your compose file, you can run this command with the --remove-orphans flag to clean it up.  
     Выполнил команду "docker compose up -d --remove-orphans". Это произошло из-за разных содержимых файлов "compose.yaml" в рабочей директории и /var/run/docker.sock.  
     Погасил проект командой "docker compose down". Если нужно убрать томы, то нужно добавить опцию "-v".        
