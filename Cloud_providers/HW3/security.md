# Безопасность в облачных провайдерах
# Домашнее задание к занятию "Безопасность в облачных провайдерах"

## Задание 1: Yandex Cloud
  1. Создал ключ в KMS, создал симметричный ключ шифрования и применил его к созданному в прошлом задании бакету. Запустил скрипт:  
     ![1](https://github.com/user-attachments/assets/f29d68be-5d61-42c6-b620-0a645d2d6553)  
     Проверил работоспособность ключа, открыв изображение в браузере:  
     ![2](https://github.com/user-attachments/assets/0569e892-e80f-42f5-a7ff-1a1e606e49af)  
  2. Создал бакет, назвал его так же, как домен и загрузил в него файл со статической страницей:  
     ![4](https://github.com/user-attachments/assets/38e233c4-a6f0-478d-8525-15786eaa2e5d)  
     Зашел в настройки бакета во вкладку веб-сайт, настроил хостинг и создал тип ANAME в записях DNS:  
     ![7](https://github.com/user-attachments/assets/b7bb9c57-d217-4814-a011-813b41087f6d)  
     Cоздал зону DNS и ресурсную запись средствами Cloud DNS:  
     ![3](https://github.com/user-attachments/assets/46e7f526-0052-4619-84ba-60fe9492b685)  
     Создал сертификат Let's Encrypt:  
     ![5](https://github.com/user-attachments/assets/326d8868-c540-4dda-96b7-ba3f850ff5b8)  
     Создал TXT-запись для прохождения процедуры проверки прав на домен:  
     ![6](https://github.com/user-attachments/assets/e9877910-fde0-499b-a508-9235570128a4)   
     Итого, в зоне DNS следующие записи:  
     ![8](https://github.com/user-attachments/assets/3bfd5532-af28-4390-bd21-775cb0b8ef5d)  
