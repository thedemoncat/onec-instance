# Образ сервера 1С:Предприятие + Apache для публикации вебсервисов

Документация по публикации ИБ - https://its.1c.ru/db/metod8dev/content/5979/hdoc

[![Build Images - 8.3.17.1851](https://github.com/TheDemonCat/onec-server-ws/actions/workflows/ci.yaml/badge.svg)](https://github.com/TheDemonCat/onec-server/actions/workflows/ci.yaml)

## Сборка 

1. Создать файл `.env` в корне проекта. В качестве примера использовать `.env.example`. В файле должны быть определены переменные:
```
    ONEC_USERNAME=<ПОЛЬЗОВАТЕЛЬ_USERS.1C.V8.RU>
    ONEC_PASSWORD=<ПАРОЛЬ_ОТ_USERS.1C.V8.RU>
```

2. В файле `ONEC_VERSION` с новой строки перечислить версии платформы, образа которым нужно собрать.

3. Запустить сборку образа с помощью скрипта

```
    ./make.sh
```

## Тестирование

Автоматическая сборка и проверка идет по версии платформы, указанной последней строке файла `ONEC_VERSION`


# NODO: Публикация ИБ в контейнере

```
webinst -publish -apache24 -wsdir <ИМЯ ПУБЛИКАЦИИ> -dir /var/www/<ИМЯ ПУБЛИКАЦИИ> -connstr “Srvr=<ИМЯ СЕРВЕРА;Ref=<ИМЯ БАЗЫ>” -confpath /etc/apache2/sites-enabled/000-default.conf
```