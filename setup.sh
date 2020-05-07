#!/bin/bash


echo "... Source Code Online Judge ..."

composer global require hirak/prestissimo

cd ./src/subCODE

composer update

php artisan key:generate --force

cd ../masterCODE

composer update

php artisan key:generate --force

php artisan jwt:secret -f

cd ../doCODE

yarn

cd ../liveCODE

yarn

echo "... Setup Complete ..."