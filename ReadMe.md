# Source Code OJ

## Catelogue

| Alias      | Service                                                | Version                      | Port        |
| ---------- | ------------------------------------------------------ | ---------------------------- | ----------- |
| nginx      | Nginx                                                  | 1.16.0                       | 80          |
| subcode    | PHP FPM                                                | 7.4                          | 8080        |
| mastercode | PHP FPM                                                | 7.4                          | 8081        |
| livecode   | Node JS                                                | 12.10.0                      | 8082        |
| docode     | Node JS                                                | 12.10.0                      | 8083        |
| minio      | Minio                                                  | RELEASE.2020-12-29T23-29-29Z | 8084        |
| db_mysql   | MySQL                                                  | 5.7.22                       | 3306        |
| redis      | Redis DB                                               | 5.0.5                        | 6379        |
| rabbitmq   | Rabbit MQ                                              | 3.7.18                       | 5672, 15672 |
| phpmyadmin | PhpMyAdmin                                             | latest                       | 50          |
| judgeMod   | [judgeMod](https://github.com/talatmursalin/judgeMod/) | -                            | -           |

---

## Getting Started

1. If you have `nginx` running natively, you've to stop that first.
   - To check: `sudo service nginx status`
   - To stop: `sudo service nginx stop`
   - To stop starting in every boot up: `sudo systemctl disable nginx`
   - NB: Sometimes it is possible that `apache2` is running, stop it by applying the same process, replace `nginx` by `apache2`(Ubuntu) or `httpd` (CentOS)
2. Open your `/etc/hosts` and add the following entries:

```
127.0.0.1 code.local
127.0.0.1 judge.code.local
127.0.0.1 master.code.local
127.0.0.1 live.code.local
127.0.0.1 content.code.local
127.0.0.1 mysql.code.local
127.0.0.1 redis.code.local
127.0.0.1 rmq.code.local
```

3. Clone this repo by this command:

   - `git clone --recursive git@github.com:RafikFarhad/sust-oj-compose.git`
   - Copy `.env.example` as `.env` and fill up values with string containing at least 10 character and digit
   - `HOST_IP` should be the ip adsress of the host pc.

4. Run `./setup.sh` and choose `1` for the first time. This command will pull/build docker images, run dependency installation and some housekeeping tasks.
5. Run `docker-compose up` or `docker-compose up -d` to deploy the system.

## Keep Up To Date

If any of the submodule update on this system, you can fecth and deploy the updates by following steps:

1. `git pull --recurse-submodules` && `git submodule update --recursive`
2. If any of the submodule updates its dependency, then you have to run

   `bash setup.sh`

   to update, otherwise this step is optional.

3. `docker-compose stop && docker-compose up -d`

## Note

- This environment by default assumes that your Linux system user id and group id is `1000:1000`. If it is not then you may face some file permission related issue on linux system. 

- Though this docker environment is built to serve a specific project, this environment can be used to use as developemnt setup for any Laravel/VueJs/ReactJs/NodeJs project.

## Feel free to:

- submit issue
- drop request to add more environment
- tweaks suggestion
