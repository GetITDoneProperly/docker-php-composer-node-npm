FROM ubuntu:xenial
MAINTAINER Get IT Done Properly <docker@doneproperly.xyz>

# Let the container know that there is no tty
ENV DEBIAN_FRONTEND noninteractive
ENV COMPOSER_NO_INTERACTION 1
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV PATH "$HOME/.composer/vendor/bin:$PATH"

# Install tools
RUN apt-get update \
	&& apt-get -y install zip unzip \
		git build-essential curl \
		software-properties-common

# Install PHP
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php \
	&& apt-get update \
	&& apt-get -y --allow-unauthenticated install \
	 php7.2-cli php7.2-mbstring php7.2-xml php7.2-curl php7.2-gd \
	 php7.2-mysql mysql-client
	
# Install Composer
RUN curl -sS https://getcomposer.org/installer \
	  -o composer-setup.php \
	&& php composer-setup.php \
		--install-dir=/usr/local/bin \
		--filename=composer
	
# Install Node & NPM
RUN curl -sL https://deb.nodesource.com/setup_8.x \
			-o nodesource_setup.sh \
	&& bash nodesource_setup.sh \
	&& apt-get -y install nodejs
