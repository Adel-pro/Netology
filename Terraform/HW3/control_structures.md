# Управляющие конструкции в коде Terraform
# Домашнее задание к занятию «Управляющие конструкции в коде Terraform»

## Чек-лист готовности к домашнему заданию
  1. Аккаунт в Yandex Cloud есть, промокод активирован.  
  2. Утилита ус установлена.  
  3. Код для задания из репозитория скачен.  
      
## Задача 1.
  1. Просмотрел проект.  
  2. Заполнил файл personal.auto.tfvars.  
  3. Выполнил команды "terrafrom init" и "terraform apply". Приложил скрин "security_group_YC.png".  

 ## Задача 2.
   1. В файле count-vm.tf создал 2 одинаковые машины web-1 и web-2 с помощью цикла count и назначил им группу безопасности из 1.3 (https://docs.comcloud.xyz/providers/yandex-cloud/yandex/latest/docs/resources/compute_instance).  
   2. В файле for_each-vm.tf создал машины с помощью цикла for_each, используя переменную each_vm.  
      Примечание: VS Code подчеркивал красным цветом "var.each_vm". Очень долго искал проблему, не нашел. Рискнул и применил "terraform plan", оказывается все в порядке, но до сих пор красное...  
   3. Использовал параметр depends_on для ВМ с web.  
   4. Применил функцию file для использования ssh ключей.  
   5. Применил команды "terraform init -upgrade" и "terraform apply".  

 ## Задача 3.
   1. В файле disk_vm.tf создал 3 виртуальных диска размером 1 Гб.  
   2. Создал ВМ с именем "storage" и подключил к ней 3 диска.  

 ## Задача 4.
   1. В файле ansible.tf использовал функцию templatefile, отредактировал файл hosts.tftpl с ипользованием созданных ранее 5 машин.  
      Проблема заключалась в том, что надо было предоставить такое решение, чтобы хоть с одной, хоть с миллион машинами скрипт отрабатывал верно. Для ВМ "storage" 1 вариант был изменение в файле hosts.tftpl цискла на строку:  
      [storage]  
      ${diskservers["name"]}   ansible_host=${diskservers["network_interface"][0]["nat_ip_address"]} fqdn=${diskservers["fqdn"]}  
      Потом поменял в файле ansible.tf "diskservers = yandex_compute_instance.storage" на "diskservers = yandex_compute_instance.storage.*", вернул цикл в файле hosts.tftpl и заработало.  
   2. Инвертарь содержит 3 группы и является динамическим.  
   3. Добавил переменную fqdn.  
   4. Применил команду "terraform apply". Прикрепил скриншот "hosts.cfg".  
