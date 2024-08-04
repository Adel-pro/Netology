## Teamcity

## Домашнее задание к занятию 11 «Teamcity»

# Подготовка к выполнению
  1. В Yandex Cloud создал новый инстанс (4CPU4RAM) на основе образа jetbrains/teamcity-server.
  2. Дождался запуска teamcity, стартовал его:
     ![1](https://github.com/user-attachments/assets/12e830a9-2b82-43e0-b8aa-3b8a88d0f73b)
     Подписал лецензию:
     ![2](https://github.com/user-attachments/assets/43d7a9d5-e96e-40d8-8111-24a2d40704e7)
     Создал аккаунт:
     ![3](https://github.com/user-attachments/assets/85cf6a93-f092-41fe-9965-479e59ffe92a)
     Перешел в главное меню teamcity:
     ![4](https://github.com/user-attachments/assets/502dd186-59a6-4a1f-a01f-b28d1c097a9a)
  3. Создал ещё один инстанс (2CPU4RAM) на основе образа jetbrains/teamcity-agent. Прописал к нему переменную окружения SERVER_URL: "http://89.169.139.198:8111".
  4. Авторизовал агент:
     ![9](https://github.com/user-attachments/assets/8f9d0f56-7c7b-4ebe-a49f-aa79a1b0babf)
  5. Сделал fork репозитория https://github.com/aragastmatb/example-teamcity.
     Ссылка на репозиторий: https://github.com/Adel-pro/example-teamcity/tree/master
  6. Создал VM (2CPU4RAM) и запустил playbook (https://github.com/netology-code/mnt-homeworks/tree/MNT-video/09-ci-05-teamcity/infrastructure):
     ![15](https://github.com/user-attachments/assets/5e1b9283-193b-4d9a-b7f4-d5e5b4b8cfed)

# Основная часть
  1. Создал новый проект в teamcity на основе fork (https://github.com/Adel-pro/example-teamcity/tree/master):
     ![5](https://github.com/user-attachments/assets/5634b93a-4759-43ce-a606-84185e61cf45)
     ![6](https://github.com/user-attachments/assets/fe1ec063-123a-487c-9a24-4bb4e4d1a79d)
  2. Сделал autodetect конфигурации:
     ![7](https://github.com/user-attachments/assets/30f4d097-a1a0-4ddb-b0ed-a9fbb8fd5973)
  3. Сохрал необходимые шаги, запустил первую сборку master:
     ![10](https://github.com/user-attachments/assets/8697c1e3-b0d3-43dc-853c-c5173eef6e6b)
     ![11](https://github.com/user-attachments/assets/a238744c-1b0a-4fbe-94f3-fa30c1da6ae9)
  4. Поменял условия сборки: если сборка по ветке master, то должен происходит mvn clean deploy, иначе mvn clean test:
     ![12](https://github.com/user-attachments/assets/c07700a9-2534-4728-9bfb-add7f9de6bd3)
  5. Для deploy загрузил settings.xml в набор конфигураций maven у teamcity.
  6. В pom.xml поменял ссылки на репозиторий и nexus.
  7. Запустил сборку по master, убедился, что всё прошло успешно и артефакт появился в nexus.
     ![16](https://github.com/user-attachments/assets/c1be1df1-420d-4caa-8ef7-4f5ee3f865de)
  8. Мигрировал build configuration в репозиторий.
  9. Создал отдельную ветку feature/add_reply в репозитории.
  10. Написал новый метод для класса Welcomer: метод должен возвращать произвольную реплику, содержащую слово hunter.
  11. Сделал push всех изменений в новую ветку в репозиторий feature/add_reply.
  12. Убедился, что сборка самостоятельно запустилась, тесты прошли успешно:
      ![14](https://github.com/user-attachments/assets/e5608bac-dcb2-4a66-98d5-50f7b9a4d8cc)
  13. Внес изменения из произвольной ветки feature/add_reply в master через Merge.
  14. Убедился, что нет собранного артефакта в сборке по ветке master.
  15. Проверил, что конфигурация в репозитории содержит все настройки конфигурации из teamcity.
