FROM php:7.2.24-apache

WORKDIR /var/www/html

RUN rm /etc/apt/preferences.d/no-debian-php

RUN  apt-get update \
     && apt-get install -y --no-install-recommends \
     git \
     docker-php-ext-install php-gd \
     docker-php-ext-install php-bcmath \
     docker-php-ext-install php-pdo-mysql \
     docker-php-ext-install php-soap \
     docker-php-ext-install php-zip \
     docker-php-ext-install php-intl \
     docker-php-ext-install libapache2-mod-php \
     docker-php-ext-install php-xsl \
     docker-php-ext-install php-curl \
     composer \
     apt-get clean

RUN a2enmod rewrite

#RUN service apache2 restart

RUN git clone https://github.com/magento/magento2.git ./magento2

RUN chown -R www-data:www-data ./magento2

#CMD apache2ctl -DFOREGROUND

#Se expone el puerto 8080 porque con el puerto 80 genera error al correr el contenedor
#EXPOSE 8080
