FROM budrom/rpi-php:7.0-fpm

ENV BOOKSTACK=BookStack \
    BOOKSTACK_VERSION=0.12.1

RUN apt-get update && apt-get install -y git zlib1g-dev libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev libpng12-dev wget libldap2-dev nginx
RUN docker-php-ext-install pdo pdo_mysql mbstring zip
RUN docker-php-ext-configure ldap --with-libdir=lib/arm-linux-gnueabihf/
RUN docker-php-ext-install ldap
RUN docker-php-ext-configure gd --with-freetype-dir=usr/include/ --with-jpeg-dir=/usr/include/ 
RUN docker-php-ext-install gd
RUN cd /var/www && curl -sS https://getcomposer.org/installer | php \
   && mv /var/www/composer.phar /usr/local/bin/composer \
   && wget https://github.com/ssddanbrown/BookStack/archive/v${BOOKSTACK_VERSION}.tar.gz -O ${BOOKSTACK}.tar.gz \
   && tar -xf ${BOOKSTACK}.tar.gz && mv BookStack-${BOOKSTACK_VERSION} ${BOOKSTACK} && rm ${BOOKSTACK}.tar.gz  \
   && cd /var/www/BookStack && composer install \
   && chown -R www-data:www-data /var/www/BookStack \
   && apt-get -y autoremove \
   && apt-get clean \
   && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY bookstack /etc/nginx/sites-available/bookstack
RUN rm -f /etc/nginx/sites-enabled/default && ln -s /etc/nginx/sites-available/bookstack /etc/nginx/sites-enabled/bookstack

COPY docker-entrypoint.sh /

EXPOSE 80

ENTRYPOINT ["/docker-entrypoint.sh"]
