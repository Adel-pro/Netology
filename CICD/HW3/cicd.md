# Процессы CI/CD
# Домашнее задание к занятию 9 «Процессы CI/CD»

## Подготовка к выполнению
  1. Создал 2 ВМ в Yandex Cloud с параметрами: 2CPU 4RAM Centos7.   
  2. Прописал в inventory-файл созданные хосты.
  3. Добавил в files файл со своим публичным ключом (id_rsa.pub).
  4. Запустил playbook, отработал с ошибками. Поменял версию postgres на 12 в файле переменных и playbook, отработал успешно.
  5. Проверил доступность SonarQube через http://84.252.130.230:9000.
  6. Зашел под admin\admin и поменял пароль.
  7. Проверил доступность Nexus через http://158.160.116.227:8081.
  8. Зашел под admin\admin123 и поменял пароль.        

## Знакомоство с SonarQube
## Основная часть
  1. Создал проект "netology".
  2. Скачал пакет sonar-scanner (https://docs.sonarsource.com/sonarqube/latest/analyzing-source-code/scanners/sonarscanner/).
  3. Добавил путь до файла bin/ в переменную PATH командой "export PATH=/home/test/Downloads/sonar-scanner-cli-5.0.1.3006-linux/sonar-scanner-5.0.1.3006-linux/bin/:$PATH".
  4. Проверил версию командой "sonar-scanner --version".  
     ![1](https://github.com/Adel-pro/Netology/assets/116494871/f834fe05-4fa6-41d0-bfaa-40be892dc545)
  5. Запустил анализатор против кода из директории example с помощью команды:  
     sonar-scanner \  
       -Dsonar.projectKey=netology \  
       -Dsonar.sources=. \  
       -Dsonar.host.url=http://84.252.130.230:9000 \  
       -Dsonar.login=c3da639fd3405e0588a48054bcac07fe0fec808f \  
       -Dsonar.coverage.exclusions=fail.py
  6. Веб-интерфейс SonarQube показал 2 bugs и 1 code smells.  
     ![2](https://github.com/Adel-pro/Netology/assets/116494871/dab07051-2bd2-4c17-bc19-a20d7bd1c091)
  7. Поправил ошибки и предупреждения.
  8. Запустил анализатор повторно, все чисто.  
     ![3](https://github.com/Adel-pro/Netology/assets/116494871/b014352b-e806-42d1-8543-d7276481a7ca)

## Знакомоство с Nexus
## Основная часть
  1. В репозиторий maven-public загрузил артефакт с необходимыми параметрами:     
     - groupId: netology
     - artifactId: java
     - version: 8_282
     - classifier: distrib
     - type: tar.gz
  2. В этот же репозиторий загрузил такой же артефакт, но с версией 8_102.
  3. Все файлы загрузились успешно.  
     ![4](https://github.com/Adel-pro/Netology/assets/116494871/d926eb2c-3122-4a7b-b253-acca69de4bf0)
  4. Файл maven-metadata.xml расположен в Netology/CICD/HW2.

## Знакомоство с Maven
## Подготовка к выполнению
  1. Скачал дистрибутив maven (https://maven.apache.org/download.cgi).
  2. Разархивировал, добавил путь до файла bin/ в переменную PATH командой "export PATH=/home/test/Downloads/apache-maven-3.9.6-bin/apache-maven-3.9.6/bin/:$PATH".
  3. Удалил раздел mirror, в котором находился "<id>maven-default-http-blocker</id>".  
     ![6](https://github.com/Adel-pro/Netology/assets/116494871/0df5b945-3e34-48be-bac7-8b48bf59deb9)
  4. Скачал java командами:  
     - sudo apt update  
     - sudo apt install default-jre  
     - sudo apt install default-jdk  
     - java -version
     Прописал переменную JAVA_HOME в файл с переменными среды командами:  
     - update-alternatives --config java  
     - sudo nano /etc/environment  
     - JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64/bin/java"  
     - source /etc/environment  
     - echo $JAVA_HOME
     Проверил версию командой "mvn --version".  
![5](https://github.com/Adel-pro/Netology/assets/116494871/fafc492e-329a-4482-9cf6-1e907157c4b0)
  5. Зашел в директорию с файлом pom.xml.
     
## Основная часть
  1. Поменял в pom.xml блок с зависимостями под нужный артефакт с версией 8_282.
  2. Запустил команду "mvn package", отработало успешно.
  3. Проверил директорию ~/.m2/repository/ и нашел артефакт с названием "netology".   
     ![7](https://github.com/Adel-pro/Netology/assets/116494871/7e20bac0-02ee-4019-b321-4c9f9b1abbe0)
  4. Файл pom.xml расположен в Netology/CICD/HW2.
