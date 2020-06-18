
FROM php:7.4-fpm-alpine3.12

WORKDIR /var/www

# installing some container dependencies
RUN apk add bash mysql-client
RUN docker-php-ext-install pdo pdo_mysql

# adding dockerize
RUN apk add --no-cache openssl
ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

# directory
RUN chmod +rwx /var/www 
# RUN rm -rf /var/www/html
COPY . /var/www

# app php dependencies
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

EXPOSE 9000
# ENTRYPOINT [ "php-fpm" ]

RUN composer install 
RUN cp .env.example .env  
# RUN php artisan serve --port 9000 

# RUN ln -s public html
