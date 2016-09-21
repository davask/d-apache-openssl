FROM davask/d-apache2:2.4-u14.04
MAINTAINER davask <docker@davaskweblimited.com>
LABEL dwl.server.https="openssl"

# declare openssl
ENV APACHE_SSL_DIR /etc/apache2/ssl
ENV DWL_SSLKEY_C "EU"
ENV DWL_SSLKEY_ST "France"
ENV DWL_SSLKEY_L "Vannes"
ENV DWL_SSLKEY_O "davask web limited - docker container"
ENV DWL_SSLKEY_CN "davaskweblimited.com"

# create apache2 ssl directories
RUN /bin/bash -c 'mkdir -p ${APACHE_SSL_DIR}'
RUN /bin/bash -c 'chmod 700 ${APACHE_SSL_DIR}'

COPY ./etc/apache2/mods-available/ssl.conf /etc/apache2/mods-available/ssl.conf
RUN /bin/bash -c 'a2enmod ssl'

COPY ./tmp/dwl/openssl.sh /tmp/dwl/openssl.sh
COPY ./tmp/dwl/init.sh /tmp/dwl/init.sh
