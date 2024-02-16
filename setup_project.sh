#!/bin/bash
set -e

echo 'Limpando imagens e cache (Docker)...'
docker stop $(docker ps -aq) && docker rm $(docker ps -qa)

echo 'Descendo o container...'
docker-compose down

echo 'Construindo o container...'
docker-compose build --no-cache

echo 'Subindo o container do banco de dados...'
docker-compose up -d db

echo 'Aguardando o MySQL iniciar...'
sleep 10  # Ajuste conforme necessário

echo 'Concedendo privilégios ao usuário...'
docker-compose exec -T db mysql -u root -pexample -e "GRANT ALL PRIVILEGES ON *.* TO 'prosas_user'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES;"

echo 'Criando e configurando o banco de dados...'
docker-compose run --rm app rails db:create db:migrate

echo 'Gerando dados de teste...'
docker-compose run --rm app rake db:create_test_data

echo 'Iniciando a Aplicação...'
docker-compose up app

echo "Aplicação subiu com sucesso!"
