# Docker for simple symfony application

Stack: php-fpm + nginx

## Changes
* created from [symfony/website-skeleton](https://github.com/symfony/website-skeleton),
* changed database to sqlite `DATABASE_URL="sqlite:///%kernel.project_dir%/var/data.db"`
* added `src/Controller/DefaultController` with `templates/default/index.html.twig` template - the controller shows current PHP version and app env,
* added frontend styles ([symfony/webpack-encore-bundle](https://symfony.com/doc/5.3/frontend/encore/installation.html)) and uncommented encore entries in `templates/base.html.twig`


## Changes v2
* added multistep docker build (Dockerfile)
* added default nginx configuration in `docker/nginx/default.conf`
* added .dockerignore
* added `docker-compose.yaml` for dev
* added `docker-compose.prod.yaml` for prod

## mysql
docker run -d -p 3308:3306 --name mysql8 -e MYSQL_ROOT_PASSWORD=password -e MYSQL_DATABASE=test mysql:8
