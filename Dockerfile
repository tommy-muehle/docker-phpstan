FROM php:7.1-alpine

RUN echo "memory_limit=-1" > $PHP_INI_DIR/conf.d/memory-limit.ini

# Get Composer
ENV COMPOSER_HOME /composer
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('SHA384', 'composer-setup.php') === '61069fe8c6436a4468d0371454cf38a812e451a14ab1691543f25a9627b97ff96d8753d92a00654c21e2212a5ae1ff36') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php --no-ansi --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"

# Get needed requirements
RUN /usr/local/bin/composer global require "hirak/prestissimo:^0.3" \
    && /usr/local/bin/composer global require phpstan/phpstan

ENV PATH /composer/vendor/bin:$PATH

VOLUME ["/app"]
WORKDIR /app

ENTRYPOINT ["phpstan"]
