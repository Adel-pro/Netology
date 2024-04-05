# Работа с roles
# Домашнее задание к занятию 4 «Работа с roles»

## Подготовка к выполнению
  1. Познакомился с LightHouse.
  2. Создал 2 пустых публичных репозитория с названиями vector-role (https://github.com/Adel-pro/vector-role) и lighthouse-role (https://github.com/Adel-pro/lighthouse-role).
  3. Публичный ключ на GitHub добавлен.   
      
## Основная часть.
  1. Создал файл requirements.yml и добавил туда источник и версию скачивания роли для clickhouse.
  2. При помощи команды "ansible-galaxy install -r requirements.yml -p roles" скачал роль в директорию "roles".
  3. Создал новый каталог с названиями "vector-role" и "lighthouse-role" с помощью команд "ansible-galaxy role init vector-role" и "ansible-galaxy role init lighthouse-role" соответственно.
  4. Заполнил новые роли, пустые директории удалил, разделил переменные между vars и default.
  5. Шаблоны конфигов добавил в директорию templates.
  6. Описал роли и их параметры в файлах README.md.
  7. Перепроверил и убедился в правильности разнесенных команд и файлов.
  8. Выложил роль "vector-role" в репозиторий командами:  
     git init  
     git remote add origin git@github.com:Adel-pro/vector-role.git  
     git add .  
     git commit -m "04.04v1"  
     git push --set-upstream origin main  
     Использовал эти же команды для роли "lighthouse-role". Добавил тег с помощью команды "git tag v1.0.0". Добавил роли с названиями "vector" и "lighthouse" в файле requirements.yml.
  9. Применил команду "ansible-playbook -i inventory/prod.yml site.yml" и убедился, что все работает.
     ![1](https://github.com/Adel-pro/Netology/assets/116494871/c5ce96fe-a1e4-474f-a029-fbf7377cd44e)
  10. Выложил playbook в репозиторий https://github.com/Adel-pro/Netology/tree/main/Ansible/HW4.
  11. Роль "vector-role": https://github.com/Adel-pro/vector-role  
      Роль "lighthouse-role": https://github.com/Adel-pro/lighthouse-role  
      Playbook: https://github.com/Adel-pro/Netology/tree/main/Ansible/HW4
