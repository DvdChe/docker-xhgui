FROM debian:stretch

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y
RUN apt-get install php7.0 apache2 gnupg wget git zip unzip -y

RUN echo 'deb http://s3-eu-west-1.amazonaws.com/qafoo-profiler/packages debian main' > /etc/apt/sources.list.d/tideways.list 

RUN wget -qO - https://s3-eu-west-1.amazonaws.com/qafoo-profiler/packages/EEB5E8F4.gpg | apt-key add -

RUN apt-get update && apt-get install \
	mongodb \
	tideways-php \
	php-mongodb \
	php-mcrypt \
	php7.0-curl \
	php7.0-gd \	
	php7.0-xml  -y 

RUN mkdir /data

VOLUME /var/www
VOLUME /data

EXPOSE 80
COPY files/entrypoint.sh /entrypoint.sh
COPY files/000-default.conf /etc/apache2/sites-available/000-default.conf
ENTRYPOINT /entrypoint.sh
