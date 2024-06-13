ARG PHP_IMAGE ${PHP_IMAGE}

FROM php:${PHP_IMAGE}

ARG USER_ADD ${USER_ADD}
ARG UID ${UID}

# workdir
ARG WORK_DIR ${WORK_DIR}
ENV WORK_DIR ${WORK_DIR}

#phpcs path
ENV PHPCS_DIR /usr/local/bin/phpcs

# nvm version
ARG NVM_VER ${NVM_VER}

# nvm path
ENV NVM_DIR /usr/local/.nvm

# node
ARG NODE_VER ${NODE_VER}
ENV NODE_VER ${NODE_VER}

#phpcs path
ENV PHPCS_DIR /usr/local/bin/phpcs

#set working directory
WORKDIR ${WORK_DIR}

# install extensions
RUN apt update && apt install -y \
    # zip dependencies
    libzip-dev zlib1g-dev unzip \
    # gd dependencies
    libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
    # docker configura
    && docker-php-ext-configure gd \
    # docker ext install
    && docker-php-ext-install \
    gd \
    bcmath \
    pdo_mysql \
    zip \
    # xdebug
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    # phpcs
    && curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar \
    && mv phpcs.phar ${PHPCS_DIR} \
    && chmod +x ${PHPCS_DIR} \
    # nvm, node, npm
    && mkdir -p ${NVM_DIR} \
    && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VER}/install.sh | bash \
    && . ${NVM_DIR}/nvm.sh \
    && nvm install ${NODE_VER} \
    && nvm install-latest-npm

# path
#ENV NODE_PATH ${NVM_DIR}/versions/node/${NODE_VER}/lib/node_modules
ENV PATH ${NVM_DIR}/versions/node/${NODE_VER}/bin:${PATH}

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Create system user to run Composer and Artisan Commands
RUN useradd -G www-data,root -u ${UID} -d /home/${USER_ADD} ${USER_ADD}
RUN mkdir -p /home/${USER_ADD}/.composer && \
    chown -R ${USER_ADD}:${USER_ADD} /home/${USER_ADD}

USER ${USER_ADD}
