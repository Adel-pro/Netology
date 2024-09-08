# Helm
# Домашнее задание к занятию «Helm»

## Задание 1. Подготовить Helm-чарт для приложения
  1. Установил helm:  
     ![1](https://github.com/user-attachments/assets/fb185000-596b-43c7-b0d3-d061d8c502c8)
  2. Создал свой чарт uniquehelm:  
     ![2](https://github.com/user-attachments/assets/b0ead5c2-32dd-4a19-ac8f-884c22dee748)
  3. Создал два файла для разных окружений dev.yaml и psi.yaml с разными версиями образа контейнера для графаны.

## Задание 2. Запустить две версии в разных неймспейсах
  1. Запустил одну версию графаны в неймспейсе app1:  
     ![3](https://github.com/user-attachments/assets/57f1ea4e-ce74-4564-a96d-63f90d8fb549)  
     Проверил результат:  
     ![4](https://github.com/user-attachments/assets/b64519e4-565b-4c0f-b327-18d1951700f0)
  2. Запустил другую версию графаны в неймспейсе app2:  
     ![5](https://github.com/user-attachments/assets/eed839ca-d9c1-423f-a8fb-0df03b32442d)
  3. Сделал проброс портов:  
     ![6](https://github.com/user-attachments/assets/4ec089c8-90b9-4d23-9445-ffa23cb2e924)  
     Графана доступна через веб-интерфейс:  
     ![7](https://github.com/user-attachments/assets/8c378d39-79ec-4241-96bd-4c2820b680c7)
