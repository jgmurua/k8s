FROM php:fpm

RUN apt update && apt-get install -y

RUN apt update && apt-get install -y --no-install-recommends \
        acl \
        libcurl4-openssl-dev \
        procps \
        zip \
        unzip \
        wget \
        git \
        zlib1g-dev \
        libxml2-dev \
        libzip-dev \
        libonig-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev && \
    docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ && \        
    docker-php-ext-install \    
        gd \
        zip \
        intl \
        mysqli \
        pdo \
        pdo_mysql \
        xml \
        curl \
        mbstring \
        opcache 

RUN pecl install xdebug \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable xdebug

# RUN usermod -u 1000 www-data
RUN echo 'deb [trusted=yes] https://repo.symfony.com/apt/ /' | tee /etc/apt/sources.list.d/symfony-cli.list
RUN apt update
RUN apt install symfony-cli gnupg -y

RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

#COPY ./xdebug/xdebug.ini $PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini
#COPY ./opcache/opcache.ini $PHP_INI_DIR/conf.d/docker-php-ext-opcache.ini
RUN git config --global user.email "you@example.com" \ 
    && git config --global user.name "Your Name"

ARG PROJECT_NAME

COPY ./$PROJECT_NAME /var/www/html/$PROJECT_NAME

RUN composer global require laravel/installer 

ENV PATH="~/.composer/vendor/bin:${PATH}"
ENV PROJECT_NAME=$PROJECT_NAME

EXPOSE 8000


WORKDIR /var/www/html/$PROJECT_NAME
CMD ["/bin/bash", "-c", "cd /var/www/html/$PROJECT_NAME && php artisan serve --host=0.0.0.0"]

