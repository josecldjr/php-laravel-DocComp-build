
FROM php:7.4-fpm-alpine3.12

WORKDIR /var/www

RUN apk add bash mysql-client
RUN docker-php-ext-install pdo pdo_mysql


RUN chmod +rwx /var/www 
# RUN rm -rf /var/www/html
COPY . /var/www
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN composer install 
RUN cp .env.example .env  
RUN php artisan key:generate  
RUN php artisan config:cache  
RUN php artisan migrate
# RUN php artisan serve --port 9000 

# RUN ln -s public html

EXPOSE 9000
ENTRYPOINT [ "php-fpm" ]