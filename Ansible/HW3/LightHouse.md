# Использование Ansible
# Домашнее задание к занятию 3 «Использование Ansible»

## Подготовка к выполнению
  1. Подготовил в Yandex Cloud три хоста: для clickhouse, для vector и для lighthouse.
     ![5](https://github.com/Adel-pro/Netology/assets/116494871/5800a501-8ba1-4adc-a9d5-b29e711016af)
  2. Ознакомился с репозиторием LightHouse.    
      
## Основная часть.
  1. Дописал playbook, добавив установку и настройку LightHouse.
  2. При создании из рекомендованных использовал модули template и apt.
  3. Включил в play следующие tasks:
     - установка git
     - установка nginx
     - настройка конфига nginx
     - установка lighthouse
     - настройка конфига lighthouse
  4. Добавил в prod.yml хост для lighthouse.
  5. Запустил команду "ansible-lint site.yml", заметил предупреждения, поправил.
     ![1](https://github.com/Adel-pro/Netology/assets/116494871/90696482-b46e-4962-ac4e-3c7fa9d383b8)
  6. Запустил команду "ansible-playbook -i inventory/prod.yml site.yml --check". Традиционно выдал ошибку на обнаружении скаченных файлов на ВМ.
     ![2](https://github.com/Adel-pro/Netology/assets/116494871/0470d67c-ce98-464c-8cd8-831f1ff5c832)
  7. Запустил команду "ansible-playbook -i inventory/prod.yml site.yml --diff". Обнаружил ошибки, поправил.
     ![3](https://github.com/Adel-pro/Netology/assets/116494871/c03905c2-53b1-48dc-b2d3-fcdc94de8a0a)
  8. Повторно запустил команду "ansible-playbook -i inventory/prod.yml site.yml --diff", изменений не произошло.
     ![4](https://github.com/Adel-pro/Netology/assets/116494871/cf34ee26-0c1a-454d-9845-35bdb3b5837c)
  9. Подготовил файл README.md для описания playbook.
  10. Готовый playbook лежит в Netology/Ansible/HW3.
