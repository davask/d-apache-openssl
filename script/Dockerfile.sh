#/usr/bin/env bash

branch=${1};
parentBranch=${2};
rootDir=${3};
buildDir=${4};

##############
# Dockerfile #
##############

echo "FROM davask/d-apache:${parentBranch}
MAINTAINER davask <docker@davaskweblimited.com>
USER root
LABEL dwl.server.https=\"openssl\"" > ${rootDir}/Dockerfile
echo '
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

RUN rm -f /etc/apache2/sites-enabled/default-ssl.conf &>> null
RUN rm -f /etc/apache2/sites-available/default-ssl.conf &>> null

COPY ./build/dwl/default/etc/apache2/mods-available/ssl.conf /etc/apache2/mods-available/ssl.conf
RUN a2enmod ssl

# Configure apache virtualhost.conf
COPY ./build/dwl/default/etc/apache2/sites-available/0000_docker.davaskweblimited.com_443.conf.dwl /dwl/default/etc/apache2/sites-available/0000_docker.davaskweblimited.com_443.conf.dwl

EXPOSE 443

COPY ./build/dwl/openssl.sh \
./build/dwl/virtualhost-ssl.sh \
./build/dwl/init.sh \
/dwl/
RUN chown root:sudo -R /dwl
USER admin
' >> ${rootDir}/Dockerfile

echo "Dockerfile generated with openssl";
