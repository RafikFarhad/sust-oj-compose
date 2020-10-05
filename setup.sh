#!/bin/bash

function pretty() {
  echo ""
  echo $1
  printf -v row "%${COLUMNS}s"; echo ${row// /#}
}

function check_envs() {
  pretty "Checking .env files"

  if ! test -f .env; then
    echo -e "Copy .env.example as .env and try again."
    exit 0
  fi

  projects=(doCODE liveCODE masterCODE subCODE)

  for project in ${projects[@]}; do
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
}

function docker_image_builds() {
  pretty "Docker image build/pull"

  docker-compose build

  docker-compose pull --ignore-pull-failures
}

function subcode_dependency_resolve() {
  pretty "subCODE dependency resolve"

  # subCODE Dependency Installation
  docker run -v "$PWD/src/subCODE/":"/var/www/subCODE" --entrypoint bash sust-oj-compose_php_sub -c "cd /var/www/subCODE && COMPOSER_MEMORY_LIMIT=1 composer --no-cache --no-interaction --no-progress --profile --prefer-dist install && php artisan key:generate --force"

  docker run -v "$PWD/src/subCODE/":"/var/www/subCODE" --entrypoint bash sust-oj-compose_livecode -c "cd /var/www/subCODE && yarn && yarn prod"
}

function mastercode_dependency_resolve() {
  pretty "masterCODE dependency resolve"

  # masterCODE Dependency Installation
  docker run -v "$PWD/src/masterCODE/":"/var/www/masterCODE" --entrypoint bash sust-oj-compose_mastercode -c "cd /var/www/masterCODE && COMPOSER_MEMORY_LIMIT=1 composer --no-cache --no-interaction --no-progress --profile --prefer-dist install && php artisan key:generate --force && php artisan jwt:secret -f"
}

function livecode_dependency_resolve() {
  pretty "liveCODE dependency resolve"

  # liveCODE Dependency Installation
  docker run -v "$PWD/src/liveCODE/":"/var/www/liveCODE" --entrypoint bash sust-oj-compose_livecode -c "cd /var/www/liveCODE && yarn"

}

function docode_dependency_resolve() {
  pretty "doCODE dependency resolve"

  # doCODE Dependency Installation
  docker run -v "$PWD/src/doCODE/":"/var/www" --entrypoint bash sust-oj-compose_docode -c "cd /var/www && yarn"
}

function minio_init() {
  pretty "Minio init"

  # Minio bucket initiator
  docker run -v "$PWD/volumes/minio":"/data" --entrypoint sh minio/minio:RELEASE.2020-01-25T02-50-51Z -c "mkdir -p /data/judge"
}

function main() {

  echo -e "... Source Code Online Judge ..."

  options=(
    "Run All"
    "Check ENV files"
    "Docker image builds"
    "subCODE    dependency resolve"
    "masterCODE dependency resolve"
    "liveCODE   dependency resolve"
    "doCODE     dependency resolve"
    "minio init"
  )

  echo "Select task:"
  actual_columns=$COLUMNS
  COLUMNS=12
  PS3="Pick an option: "
  select opt in "${options[@]}"; do
    COLUMNS=$actual_columns
    for single in ${REPLY[@]}; do
      case "$single" in

      1)
        echo -e "Executing all"
        check_envs
        docker_image_builds
        subcode_dependency_resolve
        mastercode_dependency_resolve
        livecode_dependency_resolve
        docode_dependency_resolve
        minio_init
        ;;
      2)
        check_envs
        ;;
      3)
        docker_image_builds
        ;;
      4)
        subcode_dependency_resolve
        ;;
      5)
        mastercode_dependency_resolve
        ;;
      6)
        livecode_dependency_resolve
        ;;
      7)
        docode_dependency_resolve
        ;;
      8)
        minio_init
        ;;
      *)
        pretty "$single is an invalid option."
        ;;
      esac
    done
    break
  done

  echo ""

  echo -e "... Task Complete ..."

  echo -e "Run -> docker-compose up -d"

}

main
