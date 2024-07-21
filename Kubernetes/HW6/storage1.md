# Хранение в K8s. Часть 1
# Домашнее задание к занятию «Хранение в K8s. Часть 1»

## Задание 1. Создать Deployment приложения, состоящего из двух контейнеров и обменивающихся данными.
  1. Создал Deployment приложения, состоящего из контейнеров busybox и multitool.
  2. Учел, что busybox должен писать каждые пять секунд в некий файл в общей директории.
     Используя hostPath, указал на /tmp в качестве общей директории.
  3. Обеспечил возможность чтения файла контейнером multitool.
  4. Применил Deployment:  
     ![1](https://github.com/user-attachments/assets/43ba014f-6b74-44b9-a0eb-0365a3c1e65a)  
     Убедился, что busybox пишет данные в файл каждые 5 секунд:  
     ![2](https://github.com/user-attachments/assets/e85bab97-82f3-4f4d-82ed-b397253c00b6)  
     Убедился, что multitool может читать файл, который периодически обновляется:  
     ![3](https://github.com/user-attachments/assets/d04d38fd-a61a-4c09-8ee6-511e7c4bc46a)

## Задание 2. Создать DaemonSet приложения, которое может прочитать логи ноды.
  1. Создал DaemonSet приложения, состоящего из multitool.
  2. Обеспечил возможность чтения файла /var/log/syslog кластера MicroK8S.
  3. Применил DaemonSet:  
     ![4](https://github.com/user-attachments/assets/fc9dd447-da25-4af9-886c-f985b736b6c1)  
     Убедился, что multitool может читать файл изнутри пода:  
     ![5](https://github.com/user-attachments/assets/d9088ed3-dc5f-4385-a0c5-3a1a8226c52e)
