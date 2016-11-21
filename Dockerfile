FROM php:7-fpm
MAINTAINER Darius Matulionis <darius@matulionis.lt>

# Install all required packages.
RUN apt-get update && apt-get -yqq --force-yes install \
      git \
      libldap2-dev \
      libcurl4-gnutls-dev \
      curl \
      libicu-dev \
      libmcrypt-dev \
      libvpx-dev \
      libjpeg-dev \
      libpng-dev \
      libxpm-dev \
      zlib1g-dev \
      libfreetype6-dev \
      libxml2-dev \
      libexpat1-dev \
      libbz2-dev \
      libgmp3-dev \
      libldap2-dev \
      unixodbc-dev \
      libpq-dev \
      libsqlite3-dev \
      libaspell-dev \
      libsnmp-dev \
      libpcre3-dev \
      libtidy-dev \
      build-essential \
      libkrb5-dev \
      libedit-dev \
      libedit2 \
      gcc \
      libmcrypt4 \
      make \
      python2.7-dev \
      python-pip \
      re2c \
      wget \
      sqlite3 \
      libmemcached-dev \
      screen \
      libc-client-dev

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
   readline

RUN curl -sS https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/local/bin
