# Полный образ 1С:Предприятие и EDT

[![Build Images - 8.3.17.1851](https://github.com/TheDemonCat/onec-server/actions/workflows/ci.yaml/badge.svg)](https://github.com/TheDemonCat/onec-server/actions/workflows/ci.yaml)

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
