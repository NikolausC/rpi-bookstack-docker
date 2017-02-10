[![](https://images.microbadger.com/badges/image/budrom/rpi-bookstack.svg)](https://microbadger.com/images/budrom/rpi-bookstack "Get your own image badge on microbadger.com")

# Docker Image with [BookStack](https://github.com/ssddanbrown/BookStack) for RaspberryPi (ARMv7)

## Current Version: [0.14.3](https://github.com/budrom/docker-rpi-bookstack/blob/master/Dockerfile)

## About

This is a fork from [solidnerd](https://github.com/solidnerd/docker-bookstack) modified for ARM architecture support (RaspberryPi in particular).
* Base image is my build of official PHP 7.0 image for ARM with FPM on **Raspbian** or **Alpine**.
* Changed Apache to Nginx.

## Quickstart
With Docker Compose is a Quickstart very easy. Run the following command:

```
docker-compose up
```

and after that open your Browser and go to [http://localhost:80](http://localhost:80) .

## Issues

If you have any issues feel free to create an [issue on GitHub](https://github.com/budrom/docker-rpi-bookstack/issues).

## How to use the Image without Docker compose

### Docker 1.9+
1. Create a shared network:
   `docker network create bookstack_nw`

2.  MySQL container :
```
docker run -d --net bookstack_nw  \
-e MYSQL_ROOT_PASSWORD=secret \
-e MYSQL_DATABASE=bookstack \
-e MYSQL_USER=bookstack \
-e MYSQL_PASSWORD=secret \
 --name="bookstack_db" \
 hypriot/rpi-mysql
```

3. Create BookStack Container
```
docker run -d --net bookstack_nw  \
-e DB_HOST=bookstack_db \
-e DB_DATABASE=bookstack \
-e DB_USERNAME=bookstack \
-e DB_PASSWORD=secret \
-p 80:80
 budrom/rpi-bookstack
```

After the steps you can visit [http://localhost:80](http://localhost:80) .

