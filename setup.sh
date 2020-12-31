#!/bin/bash

function pretty() {
  echo ""
  echo $1
  printf -v row "%${COLUMNS}s"
  echo ${row// /#}
}

function check_envs() {
  pretty "Checking .env files"

  if ! test -f .env; then
    echo -e "1. Copy .env.example as .env"
    echo -e "2. Update HOST_IP as your ip address"
    echo -e "3. Try again"
    exit 0
  fi

  projects=(doCODE liveCODE masterCODE subCODE)

  for project in ${projects[@]}; do
    if ! test -f "./src/${project}/.env"; then
      echo -e "No .env file in ./src/${project}/.env"
      cp "./src/${project}/.env.example" "./src/${project}/.env"
      echo -e ".env created fro .env.example"
      exit 0
    fi
  done
}

function docker_image_builds() {
  pretty "Docker image build/pull"

  docker-compose build

  docker-compose pull --ignore-pull-failures
}

function subcode_dependency_resolve() {
  pretty "subCODE dependency resolve"

  # subCODE Dependency Installation
  docker run -v "$PWD/src/subCODE/":"/var/www/subCODE" \
    --workdir /var/www/subCODE \
    --env SESSION_DRIVER=file \
    --env CACHE_DRIVER=array \
    --entrypoint bash sust-oj-compose_subcode \
    -c "COMPOSER_MEMORY_LIMIT=-1 composer --no-cache --no-interaction --no-progress --profile --prefer-dist install && php artisan key:generate --force"

  docker run -v "$PWD/src/subCODE/":"/var/www/subCODE" \
    --workdir /var/www/subCODE \
    --entrypoint bash sust-oj-compose_livecode -c "yarn && yarn production"
}

function mastercode_dependency_resolve() {
  pretty "masterCODE dependency resolve"

  # masterCODE Dependency Installation
  docker run -v "$PWD/src/masterCODE/":"/var/www/masterCODE" \
    --workdir /var/www/masterCODE \
    --env SESSION_DRIVER=file \
    --env CACHE_DRIVER=array \
    --entrypoint bash sust-oj-compose_mastercode -c "COMPOSER_MEMORY_LIMIT=-1 composer --no-cache --no-interaction --no-progress --profile --prefer-dist install && php artisan key:generate --force && php artisan jwt:secret -f"
}

function livecode_dependency_resolve() {
  pretty "liveCODE dependency resolve"

  # liveCODE Dependency Installation
  docker run -v "$PWD/src/liveCODE/":"/var/www/liveCODE" \
    --workdir /var/www/liveCODE \
    --entrypoint bash sust-oj-compose_livecode -c "yarn"

}

function docode_dependency_resolve() {
  pretty "doCODE dependency resolve"

  # doCODE Dependency Installation
  docker run -v "$PWD/src/doCODE/":"/var/www/doCODE" \
    --workdir /var/www/doCODE \
    --entrypoint bash sust-oj-compose_docode -c "yarn"
}

function minio_init() {
  pretty "Minio init"

  # Minio bucket initiator
  docker run -v "$PWD/volumes/minio":"/data" --entrypoint sh minio/minio:RELEASE.2020-12-29T23-29-29Z -c "mkdir -p /data/judge"
}

function db_update() {
  pretty "Database Update and Seed"

  # subCODE Dependency Installation
  docker run -v "$PWD/src/subCODE/":"/var/www/subCODE" \
    --workdir /var/www/subCODE \
    --env SESSION_DRIVER=file \
    --env CACHE_DRIVER=array \
    --entrypoint bash sust-oj-compose_subcode \
    -c "php artisan migrate --seed"

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
    "Database Update and Seed"
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
      9)
        db_update
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
