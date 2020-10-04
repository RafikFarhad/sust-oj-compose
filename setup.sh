#!/bin/bash

echo -e "... Source Code Online Judge ..."
if ! test -f .env; then
  echo -e "Copy .env.example as .env and try again."
  exit 0
fi

projects=( doCODE liveCODE masterCODE subCODE )

for project in ${projects[@]}
do
  if ! test -f "./src/${project}/.env"; then
    echo -e "No .env file in ./src/${project}/.env"
    echo -e "Copy .env.example as .env and try again."
    exit 0
  fi
done

if grep -Fxq "SESSION_DRIVER=redis" ./src/subCODE/.env; then
  echo -e "Replace 'SESSION_DRIVER=redis' to 'SESSION_DRIVER=file' in file './src/subCODE/.env' for development build and run again."
  exit 0
fi

if grep -Fxq "CACHE_DRIVER=redis" ./src/subCODE/.env; then
  echo -e "Replace 'CACHE_DRIVER=redis' to 'CACHE_DRIVER=file' in file './src/subCODE/.env' for development build and run again."
  exit 0
fi

if grep -Fxq "SESSION_DRIVER=redis" ./src/masterCODE/.env; then
  echo -e "Replace 'SESSION_DRIVER=redis' to 'SESSION_DRIVER=file' in file './src/masterCODE/.env' for development build and run again."
  exit 0
fi

if grep -Fxq "CACHE_DRIVER=redis" ./src/masterCODE/.env; then
  echo -e "Replace 'CACHE_DRIVER=redis' to 'CACHE_DRIVER=file' in file './src/masterCODE/.env' for development build and run again."
  exit 0
fi

docker-compose build


docker-compose pull --ignore-pull-failures

docker run -v "$PWD/src/subCODE/":"/var/www/subCODE" --entrypoint bash sust-oj-compose_php_sub -c "cd /var/www/subCODE && composer --no-cache --no-interaction --no-progress --profile --prefer-dist update && php artisan key:generate --force"


docker run -v "$PWD/src/subCODE/":"/var/www/subCODE" --entrypoint bash sust-oj-compose_livecode -c "cd /var/www/subCODE && yarn && yarn prod"


docker run -v "$PWD/src/masterCODE/":"/var/www/masterCODE" --entrypoint bash sust-oj-compose_mastercode -c "cd /var/www/masterCODE && composer --no-cache --no-interaction --no-progress --profile --prefer-dist update && php artisan key:generate --force && php artisan jwt:secret -f"


docker run -v "$PWD/src/doCODE/":"/var/www" --entrypoint bash sust-oj-compose_docode -c "cd /var/www && yarn"


docker run -v "$PWD/src/liveCODE/":"/var/www/liveCODE" --entrypoint bash sust-oj-compose_livecode -c "cd /var/www/liveCODE && yarn"


docker run -v "$PWD/volumes/minio":"/data" --entrypoint sh minio/minio:RELEASE.2020-01-25T02-50-51Z -c "mkdir -p /data/judge"


echo -e "... Setup Complete ..."

echo -e "Run -> docker-compose up -d"

echo -e "To run migration, run following commands: "
echo -e "    - docker-compose exec subcode php artisan migrate --seed"
echo -e "    - docker-compose exec mastercode php artisan migrate --seed"