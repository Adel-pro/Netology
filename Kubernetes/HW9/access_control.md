# Управление доступом
# Домашнее задание к занятию «Управление доступом»

## Задание 1. Создайте конфигурацию для подключения пользователя
  1. Создал ключ, запрос на подписание SSL-сертификата и подписал его для подключения к кластеру:  
     ![1](https://github.com/user-attachments/assets/86e7df95-9099-44f2-8136-352080223f5d)  
  2. Для настройки конфигурационного файла kubectl создал пользователя user c необходимым ключом и сертификатом:      
     ![2](https://github.com/user-attachments/assets/f94f250a-3f6d-429c-998d-1a417f1edf00)  
     Создал новый контекст и привязал к нему пользователя user:  
     ![3](https://github.com/user-attachments/assets/0e1c085b-4cc9-41f6-a71a-d7f633acf086)  
     Проверил наличие контекста:  
     ![4](https://github.com/user-attachments/assets/13952c0a-b78b-4b76-a500-df49ce9d5c4e)  
  3. Включил и проверил контроллер rbac:  
     ![5](https://github.com/user-attachments/assets/f8d2ab4d-5820-478b-91ff-561b033771b0)  
     ![6](https://github.com/user-attachments/assets/68524c64-e694-40a1-8cc9-3ae75abbde9f)   
     Создал и применил роль с правами просмотра логов подов и их конфигурации:  
     ![7](https://github.com/user-attachments/assets/c354fcea-5d13-4a0f-8a57-2a1533596471)  
     Создал и применил привязку роли к пользователю user:  
     ![8](https://github.com/user-attachments/assets/a6c5012d-b900-4c08-9197-aac966029fda)  
     Создал и применил Deployment с nginx:  
     ![9](https://github.com/user-attachments/assets/8f7dc1ff-cf2b-400b-8376-e87e2f1e7cdf)  
  4. Для проверки прав для пользователя user переключился в нужный контекст и проверил, доступно ли user просматривать логи:  
     ![10](https://github.com/user-attachments/assets/7366a4e4-40d5-46b0-a2ee-61ca59baf1c6)  
     Также проверил, доступен ли пользователю user просмотр конфигурации пода:  
     ![11](https://github.com/user-attachments/assets/ed847ec8-f5b5-49f5-9762-c18f5a32c4fd)  
     Попробовал удалить Deployment и убедился, что у пользователя user нет таких прав:  
     ![12](https://github.com/user-attachments/assets/b8d3e749-ce7e-4578-bbac-4476627615d2)
