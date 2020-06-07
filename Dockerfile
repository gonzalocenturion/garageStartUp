FROM php:7.2.28-apache

WORKDIR /var/www/html

RUN rm /etc/apt/preferences.d/no-debian-php

RUN  apt-get update \
     && apt-get install -y --no-install-recommends \     
     libicu-dev \
     libjpeg62-turbo-dev \
     libmcrypt-dev \
     libpng-dev \
     libxslt1-dev \
     libapache2-mod-php \     
     libzip-dev \
     zlib1g-dev \
     libfreetype6-dev     

#RUN docker-php-ext-configure zip --with-libzip 
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/

# Install required PHP extensions
RUN docker-php-ext-install -j$(nproc) \
      bcmath \
      gd \
      intl \
      mbstring \ 
      pdo \ 
      pdo_mysql \
      soap \
      xsl \
      zip \
      && rm -rf /var/lib/apt/lists/*   

# Enabled required PHP extensions
#RUN docker-php-ext-enable \
#  bcmath \
#  gd \
#  intl \
#  mbstring \  
#  pdo \
#  pdo_mysql \
#  soap \
#  xsl \
#  zip

# Get composer installed to /usr/local/bin/composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#ADD bin/* /usr/local/bin/

# Use the default production configuration
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

RUN useradd magento_user

RUN echo "magento_user:magento+2020" | chpasswd

RUN usermod -a -G www-data magento_user

RUN groups magento_user

COPY --chown=www-data:www-data  Magento-CE-2.3.3_sample_data-2019-09-26-04-44-35/ ./magento2

COPY src/ .

#Esta linea no funciono por lo que se tuvo que ejecutar en el contenedor que estaba corriendo
#RUN cd /var/www/html/magento2 && find var generated vendor pub/static pub/media app/etc -type f -exec chmod g+w {} + && find var generated vendor pub/static pub/media app/etc -type d -exec chmod g+ws {} + && chown -R :www-data . && chmod u+x bin/magento


RUN a2enmod rewrite




