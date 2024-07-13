# Запуск приложений в K8S
# Домашнее задание к занятию «Запуск приложений в K8S»

## Задание 1. Создать Deployment и обеспечить доступ к репликам приложения из другого Pod
  1. Создал Deployment с контейнерами nginx и multitool. Так как порты 80 и 443 заняты, то пришлось добавить переменную с указанием порта 1180 для запуска multitool.
     Запустил Deployment:
     ![1](https://github.com/user-attachments/assets/2a624ecb-eff8-48b0-83e4-2fdd75aa5916)
     и проверил, что все поднялось:
     ![2](https://github.com/user-attachments/assets/858ff57c-5d0c-4f37-b52c-7d53c54845e7)
  2. Увеличил количество реплик до 2:
     ![3](https://github.com/user-attachments/assets/093f10d1-ff42-495c-a61d-8573b3c4ce3e)
  3. Ожидаемо, количество подов увеличилось с 1 на 2.
  4. Создал Service для доступа до реплик.
  5. Создал и поднял отдельный Pod с приложением multitool:
     ![5](https://github.com/user-attachments/assets/6e4076eb-882a-42c3-a246-aaf4fb35be95)
     Убедился, что доступ до nginx есть:
     ![6](https://github.com/user-attachments/assets/66f3d7fb-6189-45e6-bc17-046b6418b019)
     Убедился, что есть доступ до multitool:
     ![7](https://github.com/user-attachments/assets/15e96390-5305-4a6c-87f7-29dc34312843)

## Задание 2. Создать Deployment и обеспечить старт основного контейнера при выполнении условий
  1. Создал Deployment приложения nginx со стартом только после того, как будет запущен сервис этого приложения. Для этого был написан bash скрипт и применен в command.
  2. Запустил Deployment и убедился, что nginx не стартует без Service.
     ![8](https://github.com/user-attachments/assets/c0426a39-b209-4c6e-b8ae-846cec843734)
  3. Создал и запустил Service.
  4. Убедился, что Deployment стартанул:
     ![9](https://github.com/user-attachments/assets/9e47326a-c4aa-4b50-a89e-71f1085c2832)
