#!/bin/bash


echo "... Source Code Online Judge ..."

docker-compose build

docker-compose pull

docker run -v "$PWD/src/subCODE/":"/var/www/subCODE" --entrypoint bash sust-oj-compose_php_sub -c "cd /var/www/subCODE && composer update && php artisan key:generate --force"

docker run -v "$PWD/src/masterCODE/":"/var/www/masterCODE" --entrypoint bash sust-oj-compose_php_master -c "cd /var/www/masterCODE && composer update && php artisan key:generate --force && php artisan jwt:secret -f"

docker run -v "$PWD/src/doCODE/":"/var/www" --entrypoint bash sust-oj-compose_docode -c "cd /var/www && yarn"

docker run -v "$PWD/src/liveCODE/":"/var/www/liveCODE" --entrypoint bash sust-oj-compose_nodejs -c "cd /var/www/liveCODE && yarn"

docker run -v "$PWD/src/subCODE/":"/var/www/subCODE" --entrypoint bash sust-oj-compose_nodejs -c "cd /var/www/subCODE && yarn && yarn prod"

echo "... Setup Complete ..."