# Работа с Playbook
# Домашнее задание к занятию 2 «Работа с Playbook»

## Подготовка к выполнению
  1. Просмотрел видео про ClickHouse и Vector.
  2. Используется публичный репозиторий на GitHub с именем Netology/Ansible.    
  4. Playbook для задания из репозитория скачен.
  5. Подготовил хосты в Yandex Cloud с образами Centos7 для ClickHouse и Ubuntu22.04 для Vector.
      
## Основная часть.
  1. Добавил в inventory-файл prod.yml публичные айпишники ВМ для ClickHouse и Vector.
  2. В playbook site.yml поправил хосты в соответствии с prod.yml, нашел установку и настройку vector (https://github.com/dzervas/ansible-vector/tree/master), адаптировал код для наших задач.
  3. При создании tasks из рекомендованных использовал модули get_url и template.
  4. Согласно tasks, скачался deb-пакет с указанной версией, установился вектор, скопировался конфиг из template и указал этот конфиг для vector, дополнены параметры systemd и дополнительные параметры привилегий, а также был поднят демон vector.
  5. Запустил команду "ansible-lint site.yml", не ругался.  
     ![5](https://github.com/Adel-pro/Netology/assets/116494871/6357e179-6c9a-4890-88a5-8b8c575c9261)
  6. Запустил команду "ansible-playbook -i inventory/prod.yml site.yml --check", не мог увидеть скаченных файлов.
     ![2](https://github.com/Adel-pro/Netology/assets/116494871/28716c2d-f918-4152-8d59-44504340e66e)  
     Понял, что флаг "--check" проверяет, но не применяет playbook. Соответственно, нужные файлы он не скачал, а лишь проверил их доступность на сайте, поэтому он их не нашел на машинах.  
  7. Запустил команду "ansible-playbook -i inventory/prod.yml site.yml --diff", подправил playbook, получил результат.
     ![3](https://github.com/Adel-pro/Netology/assets/116494871/931518c5-297b-46c6-8112-24578fcc353e)  
     Произошло только одно изменение, так как были ошибки в последнем task.
  8. Повторно запустил эту же команду, изменений не произошло.
     ![4](https://github.com/Adel-pro/Netology/assets/116494871/3f23a0ac-046f-484c-8e6d-432a11d81edb)
  9. Подготовил файл README.md, в котором описан playbook, по аналогии с https://github.com/opensearch-project/ansible-playbook.
  10. Готовый playbook лежит в Netology/Ansible/HW2. 




