# Средство визуализации Grafana
# Домашнее задание к занятию 14 «Средство визуализации Grafana»

## Задание 1
  1. Использовав директорию help, запустил prometheus-grafana.
  2. Зашел в веб-интерфейс grafana, используя login=admin и password=admin, как было указано в манифесте docker-compose.
  3. Подключил в источниках данных prometheus.
  4. Скрин веб-интерфейса grafana со списком подключенных Datasource:  
     ![3](https://github.com/Adel-pro/Netology/assets/116494871/d9f8b238-fa01-4d40-8dcf-285d648f6c81)

## Задание 2
  1. Изучил предоставленные ресурсы.
  2. Создал Dashboard и в нем создал следующие панели:  
     - утилизация CPU для nodeexporter (в процентах, 100-idle)  
       запрос: 100 - avg(irate(node_cpu_seconds_total{mode="idle"}[1m])) * 100  
     - CPULA 1/5/15  
       запросы: avg(node_load1)  
                avg(node_load5)  
                avg(node_load15)  
     - количество свободной оперативной памяти  
       запрос: node_memory_MemFree_bytes  
     - количество места на файловой системе  
       запрос: node_filesystem_avail_bytes{fstype!='tmpfs'}  
     ![1](https://github.com/Adel-pro/Netology/assets/116494871/1e1523e4-b8a8-4a5c-a4a6-a167e54f23d3)

       
## Задание 3
  1. Для каждой панели создал правила alert.
  2. Thresholds отобразились на графиках:  
     ![2](https://github.com/Adel-pro/Netology/assets/116494871/4343093e-043e-4dad-9342-13a909301974)

## Задание 4
  1. Сохранил Dashboard, перешел в его настройки, зашел в «JSON MODEL», скопировал содержимое.
  2. Сохранил содержимое в файл Netology/Monitoring/HW2/json_model.
