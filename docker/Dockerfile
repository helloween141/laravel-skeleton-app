FROM composer:2.8.12 AS composer

FROM spiralscout/roadrunner:2025.1.2 as roadrunner

FROM php:8.4-fpm-alpine as php

ENV COMPOSER_HOME="/tmp/composer" \
    SUPERCRONIC_VERSION="0.2.39"

ENV PHPIZE_DEPS \
    autoconf \
    build-base \
    libc-dev \
    libtool \
    cmake \
    make \
    file \
    re2c \
    g++ \
    gcc \
    pcre-dev \
    linux-headers

ENV PERMANENT_DEPS \
    postgresql-dev \
    oniguruma-dev \
    gettext-dev \
    libxml2-dev \
    libzip-dev \
    bzip2-dev \
    zlib-dev \
    libxslt \
    icu-dev \
    curl \
    shadow

COPY --from=composer /usr/bin/composer /usr/bin/composer
COPY --from=roadrunner /usr/bin/rr /usr/bin/rr

RUN set -x \
    && apk add --no-cache ${PERMANENT_DEPS} \
    && apk add --no-cache --virtual .build-deps ${PHPIZE_DEPS} \
    && pecl install redis \
    && docker-php-ext-install \
    pdo_pgsql \
    mbstring \
    sockets \
    gettext \
    opcache \
    bcmath \
    pcntl \
    exif \
    intl \
    pdo \
    && docker-php-ext-enable redis \
    && curl -Lf "https://github.com/aptible/supercronic/releases/download/v${SUPERCRONIC_VERSION}/supercronic-linux-amd64" \
            -o /usr/bin/supercronic \
    && chmod +x /usr/bin/supercronic \
    && apk del .build-deps \
    && rm -rf /var/cache/apk/* \
    && ln -s /usr/bin/composer /usr/bin/c \
    && adduser -D -g '' appuser \
    && addgroup appuser www-data \
    && mkdir -p /app /var/run/rr \
    && chown -R appuser:www-data /app /var/run/rr

COPY ./docker/cron/cron-jobs /etc/cron-jobs

WORKDIR /app

COPY ./composer.* /app

RUN set -x \
    && composer install --no-dev --no-interaction --no-ansi --prefer-dist --no-autoloader --no-scripts \
    && chmod -R 755 ${COMPOSER_HOME}

COPY . /app

RUN set -xe \
    && php -v \
    && composer --version \
    && rr -v \
    && supercronic -test /etc/cron-jobs \
    && composer dump

USER appuser

CMD ["rr", "serve", "-c", "/app/.rr.yml"]
