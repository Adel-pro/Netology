# Сетевое взаимодействие в K8S. Часть 2
# Домашнее задание к занятию «Сетевое взаимодействие в K8S. Часть 2»

## Задание 1. Создать Deployment приложений backend и frontend
  1. Создал Deployment приложения frontend из образа nginx с количеством реплик 3 шт:  
     ![1](https://github.com/user-attachments/assets/0b6dd9c8-78af-4bd4-9cd4-c00b2317e7a6)
  2. Создал Deployment приложения backend из образа multitool c 3 репликами:  
     ![2](https://github.com/user-attachments/assets/e2973417-3a08-4681-8ccb-54aab8c39296)
  3. Добавил Service, который обеспечивает доступ к обоим приложениям внутри кластера:  
     ![3](https://github.com/user-attachments/assets/ce31fe77-5a85-4ef3-ae5b-dd5a3f11d76c)
  4. Pod с multitool изнутри видит nginx:  
     ![4](https://github.com/user-attachments/assets/19993128-6f75-480a-bb4a-508d6e9b0955)  
     Pod с nginx изнутри может достучаться до multitool:  
     ![5](https://github.com/user-attachments/assets/ab9adabf-416f-442d-adce-a74b38204052)

## Задание 2. Создать Ingress и обеспечить доступ к приложениям снаружи кластера
  1. Включил Ingress-controller в MicroK8S:  
     ![6](https://github.com/user-attachments/assets/29027e29-5626-4638-9f42-9ed1408afb44)  
     ![7](https://github.com/user-attachments/assets/1f65fcd9-3333-440b-b762-9e56c927e5a9)
  2. Создал Ingress, обеспечивающий доступ снаружи по IP-адресу кластера MicroK8S так, чтобы при запросе только по адресу открывался frontend а при добавлении /api - backend.  
     ![8](https://github.com/user-attachments/assets/17b1026c-1b39-44c5-90d3-6dcb2d4c5ff9)
  3. Убедился, что приложения nginx и multitool доступны по доменному имени, соответствующий IP-адресу кластера, согласно записи в /etc/hosts:  
     ![9](https://github.com/user-attachments/assets/aa5da5fb-52b7-49a6-a4ac-09b2574aa4ec)
