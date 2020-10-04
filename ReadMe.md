# Source Code OJ

## Catelogue

Alias | Service | Version | Port
------|-------|------|-----------
nginx | Nginx | 1.16.0 | 80
subcode | PHP FPM | 7.4 | 8080
mastercode | PHP FPM | 7.4 | 8181
livecode | Node JS | 12.10.0 | 8082
docode | Node JS | 12.10.0 | 8083
mysql | MySQL | 5.7.22 | 8084
redis | Redis DB | 5.0.5 | 8085
rabbitmq | Rabbit MQ | 3.7.18 | 8086, 8087
minio | Minio | RELEASE.2020-01-25T02-50-51Z | 8088
phpmyadmin | PhpMyAdmin | latest | 50
judgeMod | [judgeMod](https://github.com/talatmursalin/judgeMod/) | - | -

---------------------------

## Getting Started
1. If you have `nginx` running natively, you've to stop that first.
    - To check: `sudo service nginx status` 
    - To stop: `sudo service nginx stop`
    - To stop starting in every boot up:  `sudo systemctl disable nginx`
    - NB: Sometimes it is possible that `apache2` is running, stop it by applying the same process, replace `nginx` by `apache2`(Ubuntu) or `httpd` (CentOS)
2. Open your `/etc/hosts` and add the following entries:
    - `127.0.0.1 judge.code.fs`
    - `127.0.0.1 live.code.fs`
    - `127.0.0.1 do.code.fs`
    - `127.0.0.1 content.code.fs`
    - `127.0.0.1 master.code.fs`

3. Clone this repo by this command:
    - `git clone --recursive git@github.com:RafikFarhad/sust-oj-compose.git`
    - `git update --submodules`
    - Copy `.env.example` as `.env` and fill up values with string containing at least 10 character
    - `HOST_IP` should be the ip adsress of the host pc.

4. Run `bash setup.sh`, this command will pull/build docker images, run dependency installation and some housekeeping tasks.
5. Run `docker-compose up` or `docker-compose up -d` to deploy the system
6. To run database migration, use the following two commands: 

    [ NB: This step is required for the first time and optional for the rest of the time unless database migrations are updated ]
    - `docker-compose exec subcode php artisan migrate --seed`
    - `docker-compose exec mastercode php artisan migrate --seed`

## Keep Up To Date

If any of the submodule update on this system, you can fecth and deploy the updates by following steps:

1. `git pull --recurse-submodules`
2. If submodule updates it dependency, then you have to run

    `bash setup.sh` 
    
    to update, otherwise this step is optional.
3. `docker-compose stop && docker-compose down -d`



## Note
Though this docker environment is built to serve a specific project, this environment can be used to use as developemnt setup for any Laravel/VueJs/ReactJs/NodeJs project. 

## Feel free to:
- submit issue
- drop request to add more environment
- tweaks suggestion
