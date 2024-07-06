# Базовые объекты K8S
# Домашнее задание к занятию «Базовые объекты K8S»

## Задание 1. Создать Pod с именем hello-world
  1. Создал манифест pod.yaml с конфигурацией пода
  2. Использовал образ gcr.io/kubernetes-e2e-test-images/echoserver:2.2
  3. Подключился локально к поду и проверил в браузере  
     ![4](https://github.com/Adel-pro/Netology/assets/116494871/63664313-a139-41c0-bc76-8aa6e997fa25)  
     ![1](https://github.com/Adel-pro/Netology/assets/116494871/b233b045-4397-421c-81e4-90f83ae1c4f9)

## Задание 2. Создать Service и подключить его к Pod
  1. Создал под с именем netology-web
  2. Использовал образ gcr.io/kubernetes-e2e-test-images/echoserver:2.2
  3. Создал сервис с именем netology-svc и с помощью селектора подключил netology-web
  4. Подключился локально к сервису и проверил через curl  
     ![3](https://github.com/Adel-pro/Netology/assets/116494871/f0e66641-9bba-4225-8d31-5961f05bdbdc)  
     ![5](https://github.com/Adel-pro/Netology/assets/116494871/1ad409c9-815f-48f8-8c50-dbb8415ee04d)
