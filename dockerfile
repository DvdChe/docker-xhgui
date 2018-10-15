FROM debian:stretch

ENV DEBIAN_FRONTEND=noninteractive

RUN set -eux

RUN apt-get update && apt-get upgrade -y; \
	apt-get install php7.0 apache2 gnupg wget git zip unzip -y; \
	echo 'deb http://s3-eu-west-1.amazonaws.com/qafoo-profiler/packages debian main' > /etc/apt/sources.list.d/tideways.list; \
	wget -qO - https://s3-eu-west-1.amazonaws.com/qafoo-profiler/packages/EEB5E8F4.gpg | apt-key add -

RUN apt-get update && apt-get install \
	mongodb \
	tideways-php \
	php-mongodb \
	php-mcrypt \
	php7.0-curl \
	php7.0-gd \	
	php7.0-xml  -y --no-install-recommends

RUN mkdir /data; \
	rm -v /etc/apache2/sites-available/* ;\
	rm -v /etc/apache2/sites-enabled/*; \
	rm -rfv /var/www/html/*; 

VOLUME /var/www
VOLUME /data

EXPOSE 80


COPY entrypoint.sh /entrypoint.sh
COPY xhgui.conf /etc/apache2/sites-available/xhgui.conf

RUN ln -s /etc/apache2/sites-available /etc/apache2/sites-enabled/xhgui.conf

ENTRYPOINT /entrypoint.sh
