FROM ubuntu:16.10

MAINTAINER Darius Matulionis <darius@matulionis.lt>

ENV DEBIAN_FRONTEND noninteractive

#Set variables
ENV APPPORT=8081

# Update repo and install lamp, php, php dependencies, and phpmyadmin
RUN apt-get update -yqq --force-yes --fix-missing && \
    apt-get -yqq --force-yes install apt-utils

RUN apt-get -yqq --force-yes --fix-missing install \
      apache2 curl git wget sqlite3 libc-client-dev zip unzip\
      php \
      libapache2-mod-php \
      php-cli \
      php-mbstring \
      php-pdo_mysql \
      php-curl \
      php-json \
      php-intl \
      php-gd \
      php-xml \
      php-zip \
      php-bz2 \
      php-opcache \
      php-pgsql \
      php-pdo_sqlite\
      php-intl \
      php-bcmath \
      php-soap \
      php-readline

RUN service apache2 restart

COPY laravel.conf /etc/apache2/sites-available/laravel.conf

#This will only work with GNU sed
RUN sed -i.bak "s/Listen 80/Listen 80\n\nListen $APPPORT\n/" /etc/apache2/ports.conf

RUN a2ensite 000-default && \
    a2ensite laravel && \
    a2enmod rewrite

RUN service apache2 restart

# Downloading and installing curl
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

EXPOSE 80
EXPOSE 8081

WORKDIR /var/www/html
