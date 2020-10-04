# Source Code OJ

## Catelogue

Alias | Service | Version | Port
------|-------|------|-----------
nginx | Nginx | 1.16.0 | 80
subcode | PHP FPM | 7.4 | 8080
mastercode | PHP FPM | 7.4 | 8181
livecode | Node JS | 12.10.0 | 8082
docode | Node JS | - | 8083
mysql | MySQL | 5.7.22 | 8084
redis | Redis DB | 5.0.5 | 8085
rabbitmq | Rabbit MQ | 3.7.18 | 8086, 8087
minio | Minio | RELEASE.2020-01-25T02-50-51Z | 8088
phpmyadmin | PhpMyAdmin | latest | 50
judgeMod | [judgeMod](https://github.com/talatmursalin/judgeMod/) | - | -

## Manual
1. If you have `nginx` running natively, you've to stop that first.
    - To check: `sudo service nginx status` 
    - To stop: `sudo service nginx stop`
    - To stop starting in every boot up:  `sudo systemctl disable nginx`
    - NB: Sometimes it is possible that `apache2` is running, stop it by applying the same process, replace `nginx` by `apache2`(Ubuntu) or `httpd` (CentOS)
2. Open your `/etc/hosts` and add the following two entries:
    - `127.0.0.1 judge.code.fs`
    - `127.0.0.1 live.code.fs`
    - `127.0.0.1 do.code.fs`
    - `127.0.0.1 content.code.fs`
    - `127.0.0.1 master.code.fs`

3. Clone this repo by this command:
    - `git clone --recursive git@github.com:RafikFarhad/sust-oj-compose.git`
    - `git update --submodules`
    - copy `.env.example` as `.env`
4. Go to each sub folder of `./src/`,  copy `.env.example` as `.env`, replace `HOST`, `PORT` and `SERVICE` as per as catelogue aliases, update necessary configuration also.
6. Go to [`http://content.code.fs`](http://content.code.fs) and create a storage bucket. Bucket name should be same as `./src/subCODE/.env` file `STORAGE_BUCKET_NAME=` value
7. Run `bash setup.sh`
10. Run `docker-compose up`

## Neccessary Commands

- Run these command if needed:

    \# | Native Command | Equivalent Docker Command
    --|---------------|--------------------------
    1 | composer update | docker-compose exec php composer update
    2 | chmod 777 -R ... | docker-compose exec php chmod 777 -R bootstrap public storage
    3| php artisan key:generate | docker-compose exec subcode php artisan key:generate
    4| php artisan cache:clear | docker-compose exec subcode php artisan cache:clear
    5| php artisan migrate --seed | docker-compose exec subcode php artisan migrate --seed
    6| php artisan permission:cache | docker-compose exec subcode php artisan permission:cache
    7| yarn && yarn prod | docker-compose exec livecode bash -c "cd ../subCODE && yarn && yarn prod"
    
- You can run `docker-compose up -d` to start the process in background

- After each time judgeMod image build, you have to restart the docker-compose

    `docker-compose down && docker-compose up -d`

## Note
Though this docker environment is built to serve a specific project, this environment can be used to use as developemnt setup for any Laravel/VueJs/ReactJs/NodeJs project. 

## Feel free to:
- submit issue
- drop request to add more environment
- tweaks suggestion
