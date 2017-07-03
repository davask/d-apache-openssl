FROM davask/d-apache:2.4-u14.04
MAINTAINER davask <docker@davaskweblimited.com>
USER root
LABEL dwl.server.https="openssl"

# declare openssl
ENV APACHE_SSL_DIR /etc/apache2/ssl
ENV DWL_SSLKEY_C "EU"
ENV DWL_SSLKEY_ST "France"
ENV DWL_SSLKEY_L "Vannes"
ENV DWL_SSLKEY_O "davask web limited - docker container"
ENV DWL_SSLKEY_CN "davaskweblimited.com"

# create apache2 ssl directories
RUN mkdir -p 
RUN chmod 700 

RUN rm -f /etc/apache2/sites-enabled/default-ssl.conf &>> null
RUN rm -f /etc/apache2/sites-available/default-ssl.conf &>> null

COPY ./build/dwl/default/etc/apache2/mods-available/ssl.conf /etc/apache2/mods-available/ssl.conf
RUN a2enmod ssl

# Configure apache virtualhost.conf
COPY ./build/dwl/default/etc/apache2/sites-available/0000_docker.davaskweblimited.com_443.conf.dwl /dwl/default/etc/apache2/sites-available/0000_docker.davaskweblimited.com_443.conf.dwl

EXPOSE 443

COPY ./build/dwl/openssl.sh ./build/dwl/virtualhost-ssl.sh ./build/dwl/init.sh /dwl/
RUN chmod +x /dwl/init.sh && chown root:sudo -R /dwl
USER admin
