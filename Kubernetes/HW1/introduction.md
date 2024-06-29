# Kubernetes. Причины появления. Команда kubectl
# Домашнее задание к занятию «Kubernetes. Причины появления. Команда kubectl»

## Задание 1. Установка MicroK8S
  1. Установил MicroK8S на локальную машину  
     ![1](https://github.com/Adel-pro/Netology/assets/116494871/7cbbe93e-09f0-4a7c-9890-7cade07a1254)  
     Конфиг MicroK8S находился в файле "/var/snap/microk8s/current/credentials/client.config". Использовал команду "sudo microk8s config > ~/.kube/config" для перемещения конфига в привычную директорию.
  2. Запустил команду "microk8s status --wait-ready", увидел статус MicroK8S, доступные и подключенные addons.   
     ![2](https://github.com/Adel-pro/Netology/assets/116494871/8fb4fe95-2e76-4f8e-95a3-e44bc286160a)  
     Установил dashboard  
     ![11](https://github.com/Adel-pro/Netology/assets/116494871/236df483-865e-45cc-80b6-abc5bccab22c)
  3. Добавил ip-адрес в файле "/var/snap/microk8s/current/certs/csr.conf.template"  
     ![8](https://github.com/Adel-pro/Netology/assets/116494871/f81fece8-219a-42ff-933c-328e0035b3d7)  
     Обновил сертификаты командой "sudo microk8s refresh-certs --cert front-proxy-client.crt".  
     ![13](https://github.com/Adel-pro/Netology/assets/116494871/420592d0-f50c-47f6-ac55-fb9f7447d0ae)
     
## Задание 2. Установка и настройка локального kubectl
  1. Установил на локальную машину kubectl  
     ![12](https://github.com/Adel-pro/Netology/assets/116494871/e3bb44a9-8512-4234-bb31-b4d5639e4894)
  2. Настроил локально подключение к кластеру  
     ![9](https://github.com/Adel-pro/Netology/assets/116494871/17b329f1-93b6-4e44-81b6-4a56a0f3f69e)
  3. Настроил проброс портов для подключения к дашборду  
     ![6](https://github.com/Adel-pro/Netology/assets/116494871/361d9290-52b4-4673-a708-e8ae05cc859e)  
     Подключился к дашборду   
     ![7](https://github.com/Adel-pro/Netology/assets/116494871/34911dde-dd01-4b86-a132-9bef62143e9c)  
     Открыл первоначальную страничку и ввел полученый токен  
     ![4](https://github.com/Adel-pro/Netology/assets/116494871/5e660977-40fc-4e34-aa24-415256aac9ff)  
     Зашел в дашборд  
     ![10](https://github.com/Adel-pro/Netology/assets/116494871/6bd1e256-5290-4d14-bf79-b53747a435ed)
