FROM php:7.4.0-apache-buster

WORKDIR /var/www/html

COPY index.html .

COPY Magento-CE-2.3.3_sample_data-2019-09-26-04-44-35/ /var/www/magento2

CMD apache2ctl -DFOREGROUND

RUN rm /etc/apt/preferences.d/no-debian-php

RUN \     
     apt-get update && apt-get install -y \
     php-gd \
     php-bcmath \
     php-pdo-mysql \
     php-soap \
     php-zip

RUN a2enmod rewrite

RUN service apache2 restart

EXPOSE 8080
