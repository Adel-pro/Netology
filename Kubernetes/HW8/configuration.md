# Конфигурация приложений
# Домашнее задание к занятию «Конфигурация приложений»

## Задание 1. Создать Deployment приложения и решить возникшую проблему с помощью ConfigMap. Добавить веб-страницу
  1. Создал Deployment приложения, состоящего из контейнеров nginx и multitool.
  2. Возникла проблема с портом, создал ConfigMap.
  3. Применил ConfigMap и Deployment:
     ![2](https://github.com/user-attachments/assets/315da38d-6d8c-4005-9c21-ebf772c4e7a8)  
     ![1](https://github.com/user-attachments/assets/269ba03d-11d8-4b07-b267-842418cfdf88)  
  4. Сделал простую веб-страницу и подключил её к Nginx с помощью ConfigMap.  
     Создал и подключил Service:  
     ![3](https://github.com/user-attachments/assets/23dd2e72-47d0-4679-a701-a35b995cef9a)  
     Проверил с помощью curl доступность сайта изнутри пода:  
     ![4](https://github.com/user-attachments/assets/4c0f2de1-2865-43c6-9448-0b9cb8b33906)  
     Проверил с помощью curl доступность сайта с ноды, на которой крутится под:  
     ![5](https://github.com/user-attachments/assets/2d842118-bbcb-45ee-9d96-5ce8729146f2)

 ## Задание 2. Создать приложение с вашей веб-страницей, доступной по HTTPS
   1. Создал Deployment приложения, состоящего из Nginx.
   2. Создал собственную веб-страницу и подключил её как ConfigMap к приложению.
   3. Выпустил самоподписной сертификат SSL и создал Secret для использования сертификата.
      ![6](https://github.com/user-attachments/assets/aaf00d57-bd2c-4fb6-87d5-4326faaaaeac)
   4. Создал Ingress и необходимый Service, подключил к нему SSL.
   5. Запустил ConfigMap, Service, Ingress и Deployment:  
      ![8](https://github.com/user-attachments/assets/fb69e3fb-6dc8-4b8b-9108-81ea4eb6225f)  
      Запустил Secret:  
      ![9](https://github.com/user-attachments/assets/5baf59eb-aff5-4973-b0de-a2ab452d8b82)  
      Проверил доступность сайта по https:  
      ![10](https://github.com/user-attachments/assets/ddefd83f-efda-4b60-9489-19683c3a64e0)      
