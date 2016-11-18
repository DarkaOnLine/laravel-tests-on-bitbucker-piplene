FROM php:7-fpm
MAINTAINER Darius Matulionis <darius@matulionis.lt>

# Install all required packages.
RUN apt-get update && apt-get -y --force-yes install curl wget sqlite3

# Compile PHP, include these extensions.
RUN docker-php-ext-install mbstring \
   mcrypt \
   pdo_mysql \
   curl \
   json \
   intl \
   gd \
   xml \
   zip \
   bz2 \
   opcache \
   pgsql \
   pdo_sqlite\
   intl \
   bcmath \
   soap \
   ldap \
   imap \
   readline

RUN curl -sS https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/local/bin
