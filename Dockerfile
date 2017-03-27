FROM davask/d-apache:2.4-u16.04
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
RUN mkdir -p ${APACHE_SSL_DIR}
RUN chmod 700 ${APACHE_SSL_DIR}

RUN a2dissite default-ssl.conf
RUN rm -f /etc/apache2/sites-available/default-ssl.conf &>> null

COPY ./etc/apache2/mods-available/ssl.conf /etc/apache2/mods-available/ssl.conf
RUN a2enmod ssl

COPY ./tmp/dwl/openssl.sh /tmp/dwl/openssl.sh
COPY ./tmp/dwl/init.sh /tmp/dwl/init.sh
