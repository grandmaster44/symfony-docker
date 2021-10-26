# Docker for simple symfony application

Stack: php-fpm + nginx

## Changes (app)
* created from [symfony/website-skeleton](https://github.com/symfony/website-skeleton),
* changed database to sqlite `DATABASE_URL="sqlite:///%kernel.project_dir%/var/data.db"`
* added `src/Controller/DefaultController` with `templates/default/index.html.twig` template - the controller shows current PHP version and app env,
* added frontend styles ([symfony/webpack-encore-bundle](https://symfony.com/doc/5.3/frontend/encore/installation.html)) and uncommented encore entries in `templates/base.html.twig`


## Changes (docker)
The explanation of creating docker configuration is on my website: [https://tprzyklenk.pl/symfony/symfony-produkcyjnie-przy-uzyciu-dockera/](https://tprzyklenk.pl/symfony/symfony-produkcyjnie-przy-uzyciu-dockera/)
* added multistep docker build (Dockerfile)
* added default nginx configuration in `docker/nginx/default.conf`
* added .dockerignore
* added `docker-compose.yaml` for dev
* added `docker-compose.prod.yaml` for prod

## How to run ?
Requirements:
* docker: v >= 20.10 
* docker-compose: v >= 1.29

run `docker-compose -f docker-compose.prod.yaml up -d` - the app will start on [127.0.0.1:8101](127.0.0.1:8101)
