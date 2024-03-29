# Введение в Ansible
# Домашнее задание к занятию 1 «Введение в Ansible»

## Подготовка к выполнению
  1. Установлена версия ansible 2.12.10 (https://www.cyberciti.biz/faq/how-to-install-and-configure-latest-version-of-ansible-on-ubuntu-linux/).   
  2. Публичный репозиторий на GitHub с именем Netology/Ansible создан.    
  3. Playbook для задания из репозитория скачен.  
      
## Основная часть.
  1. Запустил playbook site.yml с inventory-файлом test.yml командой "ansible-playbook -i inventory/test.yml site.yml". Значение some_fact равен 12.  
     ![1](https://github.com/Adel-pro/Netology/assets/116494871/dfdfa2dc-9547-405a-9991-a34347124a29)
  2. Значение, равное 12, было зафиксировано в файле example.yml. Поменял это значение на "all default fact".
  3. В docker поднял 2 операционки с образами centos:7 и ubuntu:latest и названием centos7 и ubuntu соответственно. Для этого использовал команды:
     docker run --name centos7 -it centos:7 bash  
     docker run --name ubuntu -it ubuntu bash
     ![2](https://github.com/Adel-pro/Netology/assets/116494871/e1c31c16-f576-4491-a2a0-5d03de246846)
  4. Запустил playbook site.yml с inventory-файлом prod.yml командой "ansible-playbook -i inventory/prod.yml site.yml". Значение some_fact для centos7 равен "el", для ubuntu - "deb".  
     ![3](https://github.com/Adel-pro/Netology/assets/116494871/48aff034-c6f4-437d-9daf-21ed13847d9f)
     Сложность заключалась в том, что в образах ubuntu не был установлен python. Менял разные образы, в итоге пришлось его установить вручную (https://phoenixnap.com/kb/how-to-install-python-3-ubuntu).  
     ![4](https://github.com/Adel-pro/Netology/assets/116494871/0b7dc88c-cf7b-4cd6-9c73-7c07de062fad)
  5. В group_vars поменял значение для deb — "deb default fact", для el — "el default fact".
  6. Повторно запустил команду "ansible-playbook -i inventory/prod.yml site.yml", все работает.  
     ![5](https://github.com/Adel-pro/Netology/assets/116494871/8828862c-2f5b-481c-bb95-25321df76568)
  7. Используя ansible-vault, зашифровал факты в group_vars/deb и group_vars/el с паролем netology командами:
     ansible-vault encrypt group_vars/deb/examp.yml
     ansible-vault encrypt group_vars/el/examp.yml
  8. Запустил команду "ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass", работает.  
     ![6](https://github.com/Adel-pro/Netology/assets/116494871/bf87dd07-90bf-4e67-8756-2b1b06217498)
  9. Командой "ansible-doc -t connection -l" посмотрел список плагинов для подключения. Наиболее подходящим для работы на control node является ssh.  
     ![7](https://github.com/Adel-pro/Netology/assets/116494871/37c861da-1c05-4bd3-a155-a89f337f022a)
  10. В prod.yml добавьте новую группу хостов:  
        local:  
          hosts:  
            localhost:  
              ansible_connection: ssh  
  11. Запустил playbook командой "ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass --ask-pass"
      ![8](https://github.com/Adel-pro/Netology/assets/116494871/67d4b185-754e-45ae-91d6-a48e95e4b839)
  12. Сохранил код в репозитории с описанием intro_ansible.md. 

## Необязательная часть.
  1. Командами "ansible-vault decrypt group_vars/deb/examp.yml" и "ansible-vault decrypt group_vars/el/examp.yml" расшифровал файлы с переменными.
  2. Зашифровал значение "PaSSw0rd" командой "ansible-vault encrypt_string" и добавил полученное значение в файл group_vars/all/exmp.yml.
  3. Запустил playbook командой "ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass --ask-pass", применился новый факт.  
     ![9](https://github.com/Adel-pro/Netology/assets/116494871/c0f8c6ab-dc59-4327-a18e-c9f96edbbdc7)
  4. Добавил новую группу хостов fedora и переменную "fedora default fact".
  5. Написал скрипт на bash, в котором поднимаются контейнеры с нужными образами, запускается ansible-playbook и останавливаются контейнеры.
  6. Все файлы хранятся в Netology/Ansible/HW1.
