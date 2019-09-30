# Source Code OJ

## Catelogue

Alias | Service | Version | Port
-|-|-|-
nginx | Nginx | 1.16.0 | 80
php | PHP FPM | 7.3 | 9000
mysql | MySQL | 5.7.22 | 3306
redis | Redis DB | 5.0.5 | 6379
rabbitmq | Rabbit MQ | 3.7.18 | 5672, 15672
nodejs | Node JS | 12.10.0 | 3333
phpmyadmin | PhpMyAdmin | - | 50

## Manual
1. If you have running `nginx` running natively, you've to close that first.
    - To check: `sudo service nginx status` 
    - To stop: `sudo service nginx stop`
    - To stop starting in every boot up:  `sudo systemctl disable nginx`
    - NB: Sometimes it is possible that `apache2` is running, stop it by applying the same process, replace `nginx` by `apache2`(Ubuntu) or `httpd` (CentOS)
2. Open your `/etc/hosts` and add the following two entries:
    - `127.0.0.1 subcode.fs`
    - `127.0.0.1 nodejs`
3. Clone this repo by this command:
    - `git clone --recursive git@github.com:RafikFarhad/sust-oj-compose.git`
    - copy `.env.example` as `.env`
4. Go to `./src` folder, here you have to copy `.env.example` as `.env` for every project and replace `HOST`, `PORT` and `SERVICE` as per as catelogue aliases
5. Go to [`http://localhost:50`](http://localhost:50) and create a database. Name should be same as `./src/subCODE/.env` file `DB_DATABASE=` value
6. Run `docker-compose up`
7. Run these command one by one:
    \# | Native Command | Equivalent Docker Command
    --|---------------|--------------------------
    1 | composer update | docker-compose exec php composer update
    2 | chmod 777 -R ... | docker-compose exec php chmod 777 -R bootstrap public storage
    3| php artisan key:generate | docker-compose exec php php key:generate
    4| php artisan cache:clear | docker-compose exec php php cache:clear
    5| yarn && yarn prod |docker-compose exec nodejs bash -c "cd ../subCODE && yarn && yarn prod"
8. Stop the `docker-compose up` process by `Ctrl + C` and start again
9. You can run `docker-compose up -d` to start the process in background


## Note
Though this docker environment is built to serve a specific project, this environment can be used to use as developemnt setup for any Laravel/VueJs/ReactJs/NodeJs project. 

## Feel free to submit issue and drop request to add more environment and tweaks