FROM budrom/rpi-php:7-fpm-alpine

ENV BOOKSTACK=BookStack \
    BOOKSTACK_VERSION=0.16.2 \
    BOOKSTACK_HOME="/var/www/bookstack"

RUN apk add --no-cache git zlib-dev freetype-dev libjpeg-turbo-dev libmcrypt-dev libpng-dev wget openldap-dev nginx bash \
   && apk add tidyhtml-dev --no-cache --repository http://nl.alpinelinux.org/alpine/edge/community/ \
   && ln -s /usr/include/tidybuffio.h /usr/include/buffio.h \
   && docker-php-ext-install pdo pdo_mysql mbstring zip tidy \
   && docker-php-ext-configure ldap --with-libdir=lib/ \
   && docker-php-ext-install ldap \
   && docker-php-ext-configure gd --with-freetype-dir=usr/include/ --with-jpeg-dir=/usr/include/ \
   && docker-php-ext-install gd \
   && cd /var/www && curl -sS https://getcomposer.org/installer | php \
   && mv /var/www/composer.phar /usr/local/bin/composer \
   && wget https://github.com/ssddanbrown/BookStack/archive/v${BOOKSTACK_VERSION}.tar.gz -O ${BOOKSTACK}.tar.gz \
   && tar -xf ${BOOKSTACK}.tar.gz && mv BookStack-${BOOKSTACK_VERSION} ${BOOKSTACK_HOME} && rm ${BOOKSTACK}.tar.gz \
   && cd $BOOKSTACK_HOME && composer install \
   && chown -R www-data:www-data $BOOKSTACK_HOME \
   && rm -rf /tmp/* /var/tmp/* && apk del wget git

COPY nginx.conf /etc/nginx/nginx.conf
COPY bookstack /etc/nginx/conf.d/bookstack
COPY docker-entrypoint.sh /

WORKDIR $BOOKSTACK_HOME

EXPOSE 80

VOLUME ["$BOOKSTACK_HOME/public/uploads","$BOOKSTACK_HOME/public/storage"]

ENTRYPOINT ["/docker-entrypoint.sh"]
