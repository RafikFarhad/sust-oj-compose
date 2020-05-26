#!/bin/bash

echo -e "... Source Code Online Judge ..."

if ! test -f .env; then
  echo -e "Copy .env.example as .env and try again."
  exit 0
fi

echo -e "\nStep 1: Passed\n"

docker-compose build

echo -e "\nStep 2: Passed\n"

docker-compose pull --ignore-pull-failures

echo -e "\nStep 3: Passed\n"

if grep -Fxq "SESSION_DRIVER=redis" ./src/subCODE/.env; then
  echo -e "Replace 'SESSION_DRIVER=redis' to 'SESSION_DRIVER=array' in file './src/subCODE/.env' for development build and run again."
  exit 0
fi

if grep -Fxq "CACHE_DRIVER=redis" ./src/subCODE/.env; then
  echo -e "Replace 'CACHE_DRIVER=redis' to 'CACHE_DRIVER=array' in file './src/subCODE/.env' for development build and run again."
  exit 0
fi
docker run -v "$PWD/src/subCODE/":"/var/www/subCODE" --entrypoint bash sust-oj-compose_php_sub -c "cd /var/www/subCODE && composer --no-cache update && php artisan key:generate --force"

echo -e "\nStep 4: Passed\n"

if grep -Fxq "SESSION_DRIVER=redis" ./src/subCODE/.env; then
  echo -e "Replace 'SESSION_DRIVER=redis' to 'SESSION_DRIVER=array' in file './src/masterCODE/.env' for development build and run again."
  exit 0
fi

if grep -Fxq "CACHE_DRIVER=redis" ./src/masterCODE/.env; then
  echo -e "Replace 'CACHE_DRIVER=redis' to 'CACHE_DRIVER=array' in file './src/masterCODE/.env' for development build and run again."
  exit 0
fi

docker run -v "$PWD/src/masterCODE/":"/var/www/masterCODE" --entrypoint bash sust-oj-compose_php_master -c "cd /var/www/masterCODE && composer --no-cache update && php artisan key:generate --force && php artisan jwt:secret -f"

echo -e "\nStep 5: Passed\n"

docker run -v "$PWD/src/doCODE/":"/var/www" --entrypoint bash sust-oj-compose_docode -c "cd /var/www && yarn"

echo -e "\nStep 6: Passed\n"

docker run -v "$PWD/src/liveCODE/":"/var/www/liveCODE" --entrypoint bash sust-oj-compose_nodejs -c "cd /var/www/liveCODE && yarn"

echo -e "\nStep 7: Passed\n"

docker run -v "$PWD/src/subCODE/":"/var/www/subCODE" --entrypoint bash sust-oj-compose_nodejs -c "cd /var/www/subCODE && yarn && yarn prod"

echo -e "\nStep 8: Passed\n"

echo -e "... Setup Complete ..."

echo -e "Run -> docker-compose up -d"