# Docker Image with [BookStack](https://github.com/BookStackApp/BookStack) for RaspberryPi (ARMv7)

## Bookstack Version: 0.26.2

## About

The repo is forked from [budrom](https://github.com/budrom/docker-rpi-bookstack)'s BookStack Docker ARM image 
with the following changes to the Dockerfile:
* Uses the latest stable version of BookStack
* Uses the newer `arm32v7/php:7.1-fpm-buster` image

The docker-entrypoint.sh script has been copied from the original [solidnerd](https://github.com/solidnerd/docker-bookstack)
repository (hence that script being MIT-licensed). budrom's [change](https://github.com/budrom/docker-rpi-bookstack/commit/cbc1cb43a9b31a85304224ba00677cefb2a949d0#diff-60713fb19f6c50a2473835df63ff17f9)
has been incorporated, to daemonize php-fpm and run nginx in the foreground, instead of apache. 

## How to use the Image

### Docker 1.9+
1. Build the Docker image:
   `docker build -t rpi-bookstack-docker .`
   
2. Create a shared network:
   `docker network create bookstack_nw`

3. Create MySQL container:
```
docker run -d --net bookstack_nw  \
-e MYSQL_ROOT_PASSWORD=secret \
-e MYSQL_DATABASE=bookstack \
-e MYSQL_USER=bookstack \
-e MYSQL_PASSWORD=secret \
 --name="bookstack_db" \
 hypriot/rpi-mysql
```

4. Create BookStack Container:
```
docker run -d --net bookstack_nw  \
-e DB_HOST=bookstack_db \
-e DB_DATABASE=bookstack \
-e DB_USERNAME=bookstack \
-e DB_PASSWORD=secret \
-p 8080:80 \
 rpi-bookstack-docker:latest
```

After completing the steps above, you can access your installation at [http://localhost:8080](http://localhost:8080).
