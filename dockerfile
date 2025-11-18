FROM php:8.2.12-fpm



RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    unzip \
    libzip-dev \
    libonig-dev \
    && docker-php-ext-install pdo pdo_mysql mbstring zip


WORKDIR /var/www/html
COPY . .
RUN curl -sS https://getcomposer.org/installer | php -- \
    && mv composer.phar /usr/local/bin/composer \
    && composer install

EXPOSE 9000

CMD ["php-fpm"]
