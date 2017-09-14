FROM ubuntu:17.04

MAINTAINER Darius Matulionis <darius@matulionis.lt>

ENV DEBIAN_FRONTEND noninteractive

#Set variables
ENV APPPORT=8081

RUN add-apt-repository ppa:ondrej/php

# Update repo and install lamp, php, php dependencies, and phpmyadmin
RUN apt-get update -yqq --force-yes --fix-missing

RUN apt-get -yqq --force-yes --fix-missing install \
      build-essential apache2 curl git wget sendmail sqlite3 libc-client-dev npm zip unzip\
      php7.1 \
      libapache2-mod-php7.1 \
      php7.1-cli \
      php7.1-mbstring \
      php7.1-mysql \
      php7.1-curl \
      php7.1-json \
      php7.1-intl \
      php7.1-gd \
      php7.1-xml \
      php7.1-zip \
      php7.1-bz2 \
      php7.1-opcache \
      php7.1-pgsql \
      php7.1-sqlite3\
      php7.1-intl \
      php7.1-bcmath \
      php7.1-soap \
      php7.1-readline


##########  Node + Yarn install  ###############
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb http://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -

RUN apt-get update -yqq --force-yes && apt-get -yqq --force-yes --fix-missing install nodejs yarn

##########  APACHE  ##############
RUN service apache2 restart

COPY laravel.conf /etc/apache2/sites-available/laravel.conf

#This will only work with GNU sed
RUN sed -i.bak "s/Listen 80/Listen 80\n\nListen $APPPORT\n/" /etc/apache2/ports.conf

RUN a2ensite 000-default && \
    a2ensite laravel && \
    a2enmod rewrite

RUN service apache2 restart

# Downloading and installing composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#GULP
#RUN npm install --global gulp-cli yarn

EXPOSE 80
EXPOSE 8081

WORKDIR /var/www/html
