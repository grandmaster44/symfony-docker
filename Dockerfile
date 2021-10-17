ARG PHP_VERSION=8.0 
ARG NGINX_VERSION=1.19

##
## PHP dev
##
FROM php:${PHP_VERSION}-fpm-alpine AS symfony_php_dev

RUN apk add --no-cache --virtual dev-deps \
        $PHPIZE_DEPS \
        git \
        zlib-dev \
        libzip-dev \
        icu-dev \
    ; \
    docker-php-ext-configure zip; \
    docker-php-ext-install \
        zip \
        intl \
    ; \
    docker-php-ext-enable \
        opcache \
    ; \
    	runDeps="$( \
		scanelf --needed --nobanner --format '%n#p' --recursive /usr/local/lib/php/extensions \
			| tr ',' '\n' \
			| sort -u \
			| awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
	)"; \
	apk add --no-cache --virtual .phpexts-rundeps $runDeps; \
    apk del dev-deps

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

WORKDIR /app

CMD ["php-fpm"]

##
## nginx dev
##
FROM nginx:${NGINX_VERSION}-alpine as symfony_nginx_dev

COPY docker/nginx/default.conf /etc/nginx/conf.d

##
## frontend
##
FROM node:16-alpine as frontend
WORKDIR /app
COPY package.json /app/package.json
COPY yarn.lock /app/yarn.lock
COPY webpack.config.js /app/webpack.config.js
RUN yarn install
COPY assets /app/assets
RUN yarn build

##
## PHP prod
##
FROM symfony_php_dev as symfony_php_prod

ENV APP_ENV=prod
RUN echo "access.log = /dev/null" >> /usr/local/etc/php-fpm.d/www.conf

COPY composer.json composer.lock symfony.lock ./

RUN mkdir -p var/cache var/log; \
    composer install --prefer-dist --no-dev --no-progress --no-scripts --no-interaction;

COPY . .

RUN composer dump-autoload --classmap-authoritative --no-dev; \
    composer symfony:dump-env prod; \
    composer run-script --no-dev post-install-cmd; \
    chmod +x bin/console; sync

RUN rm /usr/local/bin/composer

COPY --from=frontend /app/public/build /app/public/build

RUN php bin/console cache:warmup

RUN chown www-data:www-data -R /app/var

USER www-data

##
## nginx prod
##
FROM symfony_nginx_dev as symfony_nginx_prod

COPY --from=symfony_php_prod /app/public /app/public
