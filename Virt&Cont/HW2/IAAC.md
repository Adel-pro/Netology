# Применение принципов IaaC в работе с виртуальными машинами
# Домашнее задание по занятию "Применение принципов IaaC в работе с виртуальными машинами"

## Задача 1.
  На Windows-хосте в VirtualBox создал ВМ с ubuntu 20.04 и скачал туда следующие сервисы:  
    - VirtualBox (https://www.virtualbox.org/wiki/Linux_Downloads)  
    - Vagrant (https://hashicorp-releases.yandexcloud.net/vagrant/2.3.4/vagrant_2.3.4-1_amd64.deb)  
    - Packer (https://hashicorp-releases.yandexcloud.net/packer/1.9.4/packer_1.9.4_linux_amd64.zip)  
    - Плагин от Yandex Cloud (https://cloud.yandex.ru/ru/docs/tutorials/infrastructure-management/packer-quickstart)  
    - Yandex Cloud Cli (https://cloud.yandex.com/ru/docs/cli/quickstart)  
      Были проблемы с curl, помогло:  
      sudo snap remove curl  
      sudo apt install curl  
      apt --fix-broken install  
      sudo apt install curl  

## Задача 2.
  1. Создал ключ в ubuntu (ssh-keygen -t ed25519)  
  2. Создал Vagrantfile  
  3. Скачал файл-образ "bento.ubuntu-20.04" (https://app.vagrantup.com/bento/boxes/ubuntu-20.04)
  4. Добавил его в список образов Vagrant:  
     vagrant box add bento/ubuntu-20.04 2d1a0d89-0c22-4866-9e46-330c399fd977  
     vagrant box list  
  5. Запустил ВМ:  
     vagrant up  
  6. Получил ошибку  

     There was an error while executing `VBoxManage`, a CLI used by Vagrant  
     for controlling VirtualBox. The command and stderr is shown below.  

     Command: ["startvm", "48e1f4a3-eaf8-425c-821e-98c8b2a02519", "--type", "headless"]  

     Stderr: VBoxManage: error: VT-x is not available (VERR_VMX_NO_VMX) VBoxManage: error: Details: code NS_ERROR_FAILURE (0x80004005), component           ConsoleWrap, interface IConsole  

     Надо будет доразобраться!  


## Задача 3.
  1. Отредактировал файл mydebian.json.pkr.hcl, добавив docker, htop и tmux  
  2. Проверил конфигурацию образа:  
     packer validate mydebian.json.pkr.hcl  
  3. Создал образ:  
     packer build mydebian.json.pkr.hcl  
  4. Посмотрел образ:  
     yc compute image list  
  5. Создал ВМ в Yandex Cloud с созданным образом, подключился по ssh и посмотрел версию docker  
