# Simple Node Express Hello World App


![localhost:3000](/public/images/localhost_3000.png?raw=true "Node & Express")

# Steps :
```
  Commit
  Go to http://127.0.0.0:80
```
# Test:
Создать репозиторий на гитхаб с простым бекендом на node.js (либо
скопировать https://github.com/eMahtab/node-express-hello-world)
В репозитории сделать 2 ветки - master и development (код в них будет
идентичен)
Сделать jenkins pipeline который:
1) запускается на каждый новый коммит в ветке
2) подменяет порт приложения (app.js 12 строка)
master => 4200
development => 4201
3) собирает докер контейнер. для изображения добавить версию (на каждую
новую сборку она увеличивается)
4) сделать для этого контенера папку (содержимое которой не будет
удаляться при перезапуске контейнера)
5) запускать контейнер локально
# Важно:
) В один момент времени может быть запущен только 1 контейнер для
каждой ветки
