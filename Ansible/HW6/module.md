# Создание собственных модулей
# Домашнее задание к занятию 6 «Создание собственных модулей»

## Подготовка к выполнению
  1. Создал публичный репозиторий my_own_collection.
  2. Скачал репозиторий ansible.
  3. Зашел в скаченную директорию.
  4. Создал виртуальное окружение командой "python -m venv venv".
  5. Активировал виртуальное окружение командой ". venv/bin/activate".
  6. Установил зависимости командой "pip install -r requirements.txt".
  7. Запустил настройку окружения командой ". hacking/env-setup".
  8. Вышел из виртуального окружения.
      
## Основная часть.
  1. Зашел в виртуальное окружение командой ". venv/bin/activate && . hacking/env-setup" и создал новый файл my_own_module.py.
  2. Наполнил его необходимым содержимым.
  3. Написал скрипт, чтобы он создавал текстовый файл на удаленном хосте с параметрами path и content.
  4. Проверил module на исполняемость командой "python -m ansible.modules.my_own_module payload.json", предварительно создав файл payload.json, в котором указал параметры path и content.
     ![1](https://github.com/Adel-pro/Netology/assets/116494871/b98a9a28-98c8-4188-9620-0333ec2405a5)
  5. Написал playbook site.yml и использовал в нем модуль.  
     ![3](https://github.com/Adel-pro/Netology/assets/116494871/ef5b6289-87e3-4e8a-9637-549c5a12750d)
  6. Проверил playbook на идемпотентность.
     Сам файл не меняется, но добиться того, чтобы в результате ansible выдавал, что ничего не изменилось не смог. 
  8. Вышел из виртуального окружения.
  9. Создал новую колллекцию командой "ansible-galaxy collection init netology.yandex_cloud_elk".  
     ![6](https://github.com/Adel-pro/Netology/assets/116494871/b9093b92-d271-42f4-b60b-ab0175f6396a)
  10. Перенес module в директорию plugins.
  11. Создал роль test в директории roles.
  12. Создал playbook site.yml для этой роли.
  13. Заполнил файл README.md и выложил в репозиторий с тегом 1.0.0.
  14. Создал архив коллекции командой "ansible-galaxy collection build".  
      ![5](https://github.com/Adel-pro/Netology/assets/116494871/d5465c97-dcdf-403c-9d83-0458fe3f067e)
  15. Создал директорию my_project и перенес туда архив с колликцией и playbook.
  16. Установил коллекцию из архива командой "ansible-galaxy collection install netology-yandex_cloud_elk-1.0.0.tar.gz".  
      ![7](https://github.com/Adel-pro/Netology/assets/116494871/1ec30188-4ac2-4e0e-9274-8ac174b6719e)
  17. Запустил playbook, работает. 
      ![8](https://github.com/Adel-pro/Netology/assets/116494871/3199234d-88f1-46b3-b352-fb4ff69db333)
