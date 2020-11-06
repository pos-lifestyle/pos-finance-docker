FROM composer:1.10.8 as composer

FROM php:7.3.19-cli-buster

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        apache2-utils \
        curl \
        firebird-dev \
        freetds-dev \
        git \
        libbz2-dev \
        libc-client-dev \
        libfreetype6-dev \
        libgmp-dev \
        libicu-dev \
        libjpeg-dev \
        libkrb5-dev \
        libldap2-dev \
        libldb-dev \
        libmcrypt-dev \
        libpcre3-dev \
        libpng-dev \
        libpq-dev \
        libssh2-1-dev \
        libtidy-dev \
        libxml2-dev \
        libxslt-dev \
        libzip-dev \
        postgresql-client \
        ssh-client \
        unixodbc \
        unixodbc-dev \
        unzip \
        zip \
        zlib1g-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && ln -s /usr/lib/x86_64-linux-gnu/libsybdb.a /usr/lib/ \
    && ln -s /usr/include /usr/local/incl \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-configure pdo_odbc --with-pdo-odbc=unixODBC,/usr \
    && docker-php-ext-install -j$(nproc) \
        bcmath \
        bz2 \
        calendar \
        dba \
        exif \
        gd \
        gettext \
        gmp \
        imap \
        intl \
        json \
        ldap \
        mbstring \
        mysqli \
        pcntl \
        pdo_dblib \
        pdo_firebird \
        pdo_mysql \
        pdo_odbc \
        pdo_pgsql \
        pgsql \
        soap \
        sockets \
        sysvmsg \
        sysvsem \
        sysvshm \
        tidy \
        xml \
        xmlrpc \
        xsl \
        zip \
    && pecl install \
        mcrypt \
        oauth-2.0.3 \
        pcov \
        redis \
        ssh2-1.2 \
        xdebug \
    && docker-php-ext-enable \
        mcrypt \
        oauth \
        pcov \
        redis \
        ssh2

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /tmp
ENV PCOV_DIRECTORY auto
ENV PCOV_ENABLE Off
ENV PCOV_EXCLUDE ""
ENV PHP_CONFDIR /usr/local/etc/php/conf.d
ENV PHP_CONFIG_REGISTER_GLOBALS Off
ENV PHP_CONFIG_ALLOW_URL_FOPEN On
ENV PHP_CONFIG_ALLOW_URL_INCLUDE Off
ENV PHP_CONFIG_MAGIC_QUOTES_GPC On
ENV PHP_CONFIG_EXPOSE_PHP On
ENV PHP_CONFIG_MBSTRING_FUNC_OVERLOAD 0
ENV PHP_CONFIG_MEMORY_LIMIT -1
ENV PHP_CONFIG_MAX_EXECUTION_TIME 0
ENV PHP_CONFIG_UPLOAD_MAX_FILESIZE 2M
ENV PHP_CONFIG_MAX_FILE_UPLOADS 20
ENV PHP_CONFIG_MAX_INPUT_VARS 1000
ENV XDEBUG_ENABLE Off
ENV XDEBUG_IDE_KEY docker
ENV XDEBUG_REMOTE_HOST localhost
ENV XDEBUG_REMOTE_PORT 9000
ENV XDEBUG_PROFILER_ENABLE Off

RUN { \
    echo "date.timezone=\${PHP_TIMEZONE:-UTC}"; \
    echo; \
    echo "xdebug.idekey=\${XDEBUG_IDE_KEY}"; \
    echo "xdebug.remote_enable=On"; \
    echo "xdebug.remote_connect_back=Off"; \
    echo "xdebug.remote_autostart=\${XDEBUG_REMOTE_AUTOSTART}"; \
    echo "xdebug.remote_host=\${XDEBUG_REMOTE_HOST}"; \
    echo "xdebug.remote_port=\${XDEBUG_REMOTE_PORT}"; \
    echo; \
    echo "xdebug.profiler_enable=\${XDEBUG_PROFILER_ENABLE}"; \
    echo "xdebug.profiler_enable_trigger=\${XDEBUG_PROFILER_ENABLE_TRIGGER}"; \
    echo "xdebug.profiler_enable_trigger_value=\${XDEBUG_PROFILER_ENABLE_TRIGGER_VALUE}"; \
    echo "xdebug.profiler_output_dir=\${XDEBUG_PROFILER_OUTPUT_DIR}"; \
    echo "xdebug.profiler_output_name=\${XDEBUG_PROFILER_OUTPUT_NAME}"; \
    echo; \
    echo "pcov.enabled=\${PCOV_ENABLE}"; \
    echo "pcov.directory=\${PCOV_DIRECTORY}"; \
    echo "pcov.exclude=\${PCOV_EXCLUDE}"; \
    echo; \
    echo "register_globals=\${PHP_CONFIG_REGISTER_GLOBALS}"; \
    echo "allow_url_fopen=\${PHP_CONFIG_ALLOW_URL_FOPEN}"; \
    echo "allow_url_include=\${PHP_CONFIG_ALLOW_URL_INCLUDE}"; \
    echo "magic_quotes_gpc=\${PHP_CONFIG_MAGIC_QUOTES_GPC}"; \
    echo "expose_php=\${PHP_CONFIG_EXPOSE_PHP}"; \
    echo "mbstring.func_overload=\${PHP_CONFIG_MBSTRING_FUNC_OVERLOAD}"; \
    echo "memory_limit=\${PHP_CONFIG_MEMORY_LIMIT}"; \
    echo "max_execution_time=\${PHP_CONFIG_MAX_EXECUTION_TIME}"; \
    echo "upload_max_filesize=\${PHP_CONFIG_UPLOAD_MAX_FILESIZE}"; \
    echo "max_file_uploads=\${PHP_CONFIG_MAX_FILE_UPLOADS}"; \
    echo "max_input_vars=\${PHP_CONFIG_MAX_INPUT_VARS}"; \
} | tee "${PHP_CONFDIR}/pos-finance.ini"

COPY --from=composer /usr/bin/composer /usr/local/bin/composer

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        nodejs \
        yarn \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY docker-php-entrypoint /usr/local/bin/

ENTRYPOINT [ "docker-php-entrypoint" ]

CMD [ "php", "-a" ]
