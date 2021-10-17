# Simple symfony application

This is a simple symfony application ready for dockerization.

## Changes
* created from [symfony/website-skeleton](https://github.com/symfony/website-skeleton),
* changed database to sqlite `DATABASE_URL="sqlite:///%kernel.project_dir%/var/data.db"`
* added `src/Controller/DefaultController` with `templates/default/index.html.twig` template - the controller shows current PHP version and app env,
* added frontend styles ([symfony/webpack-encore-bundle](https://symfony.com/doc/5.3/frontend/encore/installation.html)) and uncommented encore entries in `templates/base.html.twig`
