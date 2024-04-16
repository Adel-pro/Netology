# Жизненный цикл ПО
# Домашнее задание к занятию 7 «Жизненный цикл ПО»

## Подготовка к выполнению
  1. Получил бесплатную версию Jira (https://www.atlassian.com/ru/software/jira/work-management/free).   
  2. Ознакомился с дополнительной инструкцией (https://support.atlassian.com/jira-cloud-administration/docs/import-and-export-issue-workflows/).          
      
## Основная часть.
  1. Создал задачу с типом bug.  
     ![kanban_bug1](https://github.com/Adel-pro/Netology/assets/116494871/38c67d45-ddeb-43e3-af07-46703d1c9305)  
     Провел ее по всему workflow по схеме:  
      - Open -> On reproduce.  
      - On reproduce -> Open, Done reproduce.  
      - Done reproduce -> On fix.  
      - On fix -> On reproduce, Done fix.  
      - Done fix -> On test.  
      - On test -> On fix, Done.  
      - Done -> Closed, Open.  
     ![kanban_bug2](https://github.com/Adel-pro/Netology/assets/116494871/2c59e8b3-8edb-497a-82a4-7217516aedea)
  2. Создал задачу с типом epic и привязал к ней 2 задачи.  
     ![kanban_tasks1](https://github.com/Adel-pro/Netology/assets/116494871/2c1a1df0-197b-4a6a-bf11-5ee7348be447)  
     Провел ее по всему workflow по схеме:  
      - Open -> On develop.  
      - On develop -> Open, Done develop.    
      - Done develop -> On test.   
      - On test -> On develop, Done.  
      - Done -> Closed, Open.  
     ![kanban_tasks2](https://github.com/Adel-pro/Netology/assets/116494871/8e39b042-aab8-4c3a-a8b1-12bd01304bf7)
  3. В 1ом и 2ом пунктах использовал Kanban.
  4. Вернул задачи в Open.
  5. Перешел в Scrum, запланировал новый спринт, состоящий из задач epic и одного бага, стартовал спринт, провел их до состояния Closed и закрыл спринт.  
     ![scrum2](https://github.com/Adel-pro/Netology/assets/116494871/b9e2b96e-2dc6-4a66-bb9a-eedd6df636aa)
  6. Выгрузил схемы workflow в XML формате и закинул в репозиторий Netology/CICD/HW1.
