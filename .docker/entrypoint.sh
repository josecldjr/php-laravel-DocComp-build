#!/usr/bin/env bash

# php artisan key:generate
# RUN php artisan key:generate  
# RUN php artisan config:cache
php artisan migrate
php-fpm
