# Продвинутые методы работы с Terraform
# Домашнее задание к занятию «Продвинутые методы работы с Terraform»

## Чек-лист готовности к домашнему заданию
  1. Аккаунт в Yandex Cloud есть, промокод активирован.  
  2. Утилита ус установлена.  
  3. Код для задания из репозитория скачен.
  4. Используются прерываемые ВМ и после каждого перерыва/домашнего задания удаляются.   
      
## Задача 1.
  1. Скопировал из демонстрации remote-модули для двух ВМ, заменил хардкод, добавил labels "project: marketing" и "project: analytics" для отличия двух машин. Создал файл cloud-init.yml, куда добавил данные для подключения к ВМ через ssh. Для передачи ssh-ключа использовал функцию template_file.
  2. Добавил в файл cloud-init.yml установку nginx. Проинциализировал и запустил проект командами "terraform init" и "terraform apply" соответственно.
  3. Подключился к ВМ через ssh и убедился, что nginx установился командой "sudo nginx -t".  
   ![YC](https://github.com/Adel-pro/Netology/assets/116494871/ed47c4b3-af39-4cbb-879b-9bf85788fac2)

   ![nginx](https://github.com/Adel-pro/Netology/assets/116494871/c967b4da-9e8c-45f1-abaa-7f61ad9277a9)  
     
     В terraform console посмотрел содержимое модуля командой "module.marketing".  
   ![console](https://github.com/Adel-pro/Netology/assets/116494871/b9637d2e-cd72-468f-b13b-624f30e11b89)

## Задача 2.
  1. Для создания локального модуля vpc создал директорию с названием "vpc" и файлы "main.tf", "output.tf", "variables.tf" и "providers.tf". В файле "main.tf" создал 2 ресурса для создания сети и подсети.
  2. Передал в модуль vpc переменные с названием сети, зоны и подсеткой с маской.
  3. Добавил в файле "output.tf" информацию о yandex_vpc_subnet. В terraform console посмотрел содержимое модуля командой "module.vpc_dev".  
     ![output](https://github.com/Adel-pro/Netology/assets/116494871/d401d12a-f1a4-4142-87e9-e1bab916b73b)  
  4. Заменил ресурсы yandex_vpc_network и yandex_vpc_subnet, необходимые параметры в модулях "marketing" и "analytics", а также в файле "providers.tf" строчку zone, которая была привязана к переменной, на "zone = module.vpc_dev.vpc_subnet.zone".
  5. Сгенерировал документацию к модулю командой "terraform-docs markdown ./vpc".

## Задача 3.
  1. Вывел список ресурсов в state командой "terraform state list".
     ![state1](https://github.com/Adel-pro/Netology/assets/116494871/88d2ece6-320f-4057-80e2-8f6937b7655b)
  2. Посмотрел id модулей vpc и удалил их из state.
     ![state2](https://github.com/Adel-pro/Netology/assets/116494871/37ff7dc8-88c9-4783-b2f2-d47caec36ec0)
     ![state3](https://github.com/Adel-pro/Netology/assets/116494871/c8b2f547-ce16-4dfc-8554-ad1db612d948)
  3. Посмотрел id модулей vm и удалил их из state.
     ![state4](https://github.com/Adel-pro/Netology/assets/116494871/335823ac-ecab-473e-8145-7715218ec9fc)
     ![state5](https://github.com/Adel-pro/Netology/assets/116494871/a3df5c60-0a58-4f4d-a52f-dea3a1bfb3f2)
  4. Импортировал все обратно.
     ![state6](https://github.com/Adel-pro/Netology/assets/116494871/89b3dcb0-a2b8-4933-ad7a-f64e5b721719)

     ![state7](https://github.com/Adel-pro/Netology/assets/116494871/b12b9808-67da-495d-aa2f-993b180a643f)

     В terraform plan значительных изменений не произошло.
     ![state8](https://github.com/Adel-pro/Netology/assets/116494871/e75d676f-46a7-4487-af6f-714bec0cdcfe)

## Задача 4.
1. Изменил модуль vpc так, что он на выходе передавал подсети, созданные во всех зонах. Для этого на выход модуля была передана переменная subnets типа list(object).
   ![YC2](https://github.com/Adel-pro/Netology/assets/116494871/fc3b6dba-9771-420e-9581-f5932034a589)

## Задача 5.
1. Написал модуль mysql для создания кластера БД Mysql "example" в Yandex Cloud с двумя хостами (HA=true) с использованием ресурса yandex_mdb_mysql_cluster. На вход модуля передал имя кластера, необходимую информацию о сети и сведения для подключения к лк в Yandex Cloud.
2. Написал модуль для создания базы данных и пользователя в кластере "example" при помощи ресурсов yandex_mdb_mysql_database и yandex_mdb_mysql_user. На вход модуля передал имя базы данных, имя пользователя и пароль, id кластера и сведения для подключения к лк в Yandex Cloud.
3. Использовал оба модуля для создания кластера.
4. Выполнил команды "terraform init", "terraform plan" и "terraform apply". Кластер создавался больше 5 минут. В итоге, остановил проект командой "terraform destroy".
   ![cluster](https://github.com/Adel-pro/Netology/assets/116494871/6c5d642d-caaa-4adb-8afb-7de58ce846a3)


## Задача 6.
1. Используя пример из https://github.com/terraform-yc-modules/terraform-yc-s3, создал module "simple-bucket" размером 1 ГБ.
   ![bucket](https://github.com/Adel-pro/Netology/assets/116494871/be355ad7-5bd9-410e-9dfc-aec5480a4269)
