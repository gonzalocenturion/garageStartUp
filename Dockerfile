FROM php:7.4.0-apache-buster

WORKDIR /var/www/html

RUN rm /etc/apt/preferences.d/no-debian-php

RUN  apt-get update \
     && apt-get install -y --no-install-recommends \
     php-gd \
     php-bcmath \
     php-pdo-mysql \
     php-soap \
     php-zip \
     && rm -rf /var/lib/apt/lists/* 

RUN a2enmod rewrite

RUN service apache2 restart

<<<<<<< HEAD
#COPY index.html .

=======
>>>>>>> 0bb0673fea4b88cfaa5b746344e245d47b59cbbd
COPY --chown=www-data:www-data  Magento-CE-2.3.3_sample_data-2019-09-26-04-44-35/ /var/www/html/magento2

CMD apache2ctl -DFOREGROUND

<<<<<<< HEAD
=======
#Se expone el 8080 porque con el 80 genera error al correr el contenedor
>>>>>>> 0bb0673fea4b88cfaa5b746344e245d47b59cbbd
EXPOSE 8080
