# Вычислительные мощности. Балансировщики нагрузки
# Домашнее задание к занятию "Вычислительные мощности. Балансировщики нагрузки"

## Задание 1: Yandex Cloud
  1. Создал бакет в Object Storage с именем "adel-04-11", положил в бакет файл с картинкой "image.jpeg", сделал файл доступным из интернета.
  2. Создал Instance Group с тремя ВМ и шаблоном LAMP. Для LAMP использовал image_id = fd827b91d99psvq5fjit. Для создания стартовой веб-страницы использовал раздел user_data в meta_data. Разместил в стартовой веб-странице шаблонной ВМ ссылку на картинку из бакета и настроил проверку состояния ВМ.  
     Применил код:  
     ![3](https://github.com/user-attachments/assets/053d1ba9-675e-42b8-b3f6-23c231f1697f)  
     Увидел созданные ВМ:  
     ![1](https://github.com/user-attachments/assets/16b840d7-ce84-4f3e-896c-c7a2156fa447)  
     Проверил доступность сайта с картинкой:  
     ![2](https://github.com/user-attachments/assets/b3073a2c-d489-4415-8cc7-1c9745e99d7c)
  3. Создал сетевой балансировщик, применил код:   
     ![5](https://github.com/user-attachments/assets/934ea04a-76a3-487c-83c2-2b56eccbce1a)  
     Старые ВМ удалились, создались новые ВМ:  
     ![4](https://github.com/user-attachments/assets/374b10d7-fe43-43fa-a3cb-1a596d4b801c)  
     ![6](https://github.com/user-attachments/assets/78bc2809-f366-4e50-a4d7-ecccf217cf73)  
     Удалил одну ВМ и проверил работоспособность сетевого балансировщика:  
     ![7](https://github.com/user-attachments/assets/8a90397b-8d27-4bf2-a2ae-ba236fc9e7e6)  
     ![8](https://github.com/user-attachments/assets/ae4fffbc-b7eb-4ccf-ac38-c0b412d8fef5)
