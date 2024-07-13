# Сетевое взаимодействие в K8S. Часть 1
# Домашнее задание к занятию «Сетевое взаимодействие в K8S. Часть 1»

## Задание 1. Создать Deployment и обеспечить доступ к контейнерам приложения по разным портам из другого Pod внутри кластера
  1. Создал и применил Deployment приложения, состоящего из двух контейнеров (nginx и multitool), с количеством реплик 3 шт:  
     ![1](https://github.com/user-attachments/assets/a0fafdeb-06f1-4502-a685-36b4fa997b8c)
  2. Создал и применил Service, обеспечивающий доступ внутри кластера до контейнеров nginx и multitool по порту 9001 — nginx 80, по 9002 — multitool 8080:  
     ![2](https://github.com/user-attachments/assets/27defe8e-3e9c-4d0b-957e-66c761f487b7)
  3. Создал и применил отдельный Pod с приложением multitool:  
     ![3](https://github.com/user-attachments/assets/dd9236a7-c8a6-46b1-8ed4-9ee10037ccd7)  
     Убедился, что из пода есть доступ до nginx по IP-адресу:  
     ![4](https://github.com/user-attachments/assets/186d74c2-b3de-4c79-9130-7d803d8b468c)  
     Убедился, что из пода есть доступ до multitool по IP-адресу:  
     ![5](https://github.com/user-attachments/assets/8a3b9332-7a9b-47d5-bd30-5883efe6ed11)
  5. Убедился, что из пода есть доступ до nginx и multitool по доменному имени Service:  
     ![6](https://github.com/user-attachments/assets/a4e1465b-eb61-40d7-a37e-81a108ee21e2)

## Задание 2. Создать Service и обеспечить доступ к приложениям снаружи кластера
  1. Создал и применил отдельный Service для nginx и multitool с возможностью доступа снаружи кластера к nginx и multitool, используя тип NodePort:  
     ![7](https://github.com/user-attachments/assets/07cedd19-5ad4-482c-87a7-4eec3ab3e53f)
  2. Убедился, что есть доступ до nginx и multitool с IP-адреса хоста:  
     ![8](https://github.com/user-attachments/assets/5df18ad9-7d79-4c8c-94c1-3ec1e680a311)
