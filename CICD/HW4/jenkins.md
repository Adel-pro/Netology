# Jenkins
# Домашнее задание к занятию 10 «Jenkins»

## Подготовка к выполнению
  1. Создал 2 ВМ с операционкой centos7: jenkins-master и jenkins-agent.   
  2. Установил Jenkins при помощи playbook.  
     ![1](https://github.com/Adel-pro/Netology/assets/116494871/2eda0fe6-5672-41d6-ad52-c40b53d1ec9a)
  3. Проверил, что мастер запускается.
  4. Сделал первоначальную установку:  
     а. Доинсталлировал мастер через веб-интерфейс.  
     b. Скачал плагин (https://plugins.jenkins.io/command-launcher/).  
     c. Создал агента и подцепил его к мастеру по ssh, указав путь до файла agent.jar.  
     d. В настройках мастера количество процессов-исполнителей выставил 0.         
      
## Основная часть.
  1. Создал Freestyle Job, который запускает molecule test на агенте, скачивая роль из репозитория https://github.com/Adel-pro/vector-role.  
     ![2](https://github.com/Adel-pro/Netology/assets/116494871/b4994b04-902f-4839-8bc0-f4ebf58abf5a)  
     Агент не мог подцепиться к репозиторию, выдавал ошибку "You’re using ‘Known hosts file’ strategy". Помогла команда "ssh -T git@github.com -i id_rsa", запущенная от пользователя jenkins. Molecule запустился, выдал ошибку при тестировании роли.  
     ![3](https://github.com/Adel-pro/Netology/assets/116494871/d7a19378-158c-4d57-8139-8b49966df657)
  2. Создал Declarative Pipeline Job, который запускает molecule test на агенте, ссылаясь на уже скаченный репозиторий.  
     ![4](https://github.com/Adel-pro/Netology/assets/116494871/037e2e92-40da-4205-88bd-f628eb700d81)
  3. Созданный pipeline script скопировал и вставил в файл Jenkinsfile в репозитории https://github.com/Adel-pro/vector-role.
  4. Создал Multibranch Pipeline на запуск Jenkinsfile из репозитория, результат тот же, что и в пункте 2.  
     ![5](https://github.com/Adel-pro/Netology/assets/116494871/5659505b-3066-432d-9de1-6f59098896c3)
  5. Создал Scripted Pipeline с необходимым скриптом.
  6. Добавил в него параметр prod_run и изменил скрипт.
  7. Проверил работоспособность, в репозитории отсутствуют необходимый порядок и соответствующие файлы, так как репозиторий предназначен только для хранения роли.  
     ![6](https://github.com/Adel-pro/Netology/assets/116494871/09687d43-5202-4845-9d3f-0c40b5b30697)
     Исправленный Pipeline вложил в репозиторий Netology/CICD/HW4 в файл ScriptedJenkinsfile.
  8. Ссылка на репозиторий с ролью: https://github.com/Adel-pro/vector-role  
     Declarative Pipeline (Jenkinsfile) и Scripted Pipeline (ScriptedJenkinsfile) находятся в Netology/CICD/HW4.


