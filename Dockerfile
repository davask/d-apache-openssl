FROM davask/d-apache2:2.4-u14.04
MAINTAINER davask <contact@davaskweblimited.com>
USER root
LABEL dwl.server.https="open ssl"

# declare container type
ENV DWL_INIT ssl

# declare ssl
ENV APACHE_SSL_DIR /etc/apache2/ssl
ENV CERTBOT_LOG_DIR /var/log/letsencrypt
ENV DWL_USER_DNS dev.davaskweblimited.com
ENV DWL_CERTBOT_EMAIL admin@davaskweblimited.com

ENV DWL_SSLKEY_C "EU"
ENV DWL_SSLKEY_ST "Germany"
ENV DWL_SSLKEY_L "Erlangen"
ENV DWL_SSLKEY_O "davask web limited - docker container"
ENV DWL_SSLKEY_CN "davaskweblimited.com"

# create apache2 ssl directories
RUN /bin/bash -c 'mkdir -p ${APACHE_SSL_DIR}'
# create certbot directories
RUN /bin/bash -c 'mkdir -p ${CERTBOT_LOG_DIR}'

# install certbot
RUN /bin/bash -c 'wget https://dl.eff.org/certbot-auto'
RUN /bin/bash -c 'mv certbot-auto /usr/local/bin'
RUN /bin/bash -c 'chmod a+x /usr/local/bin/certbot-auto'
RUN /bin/bash -c 'certbot-auto --noninteractive --os-packages-only'
RUN /bin/bash -c 'rm -rf /var/lib/apt/lists/*'

# Configure apache ssl
COPY ./etc/apache2/mods-available /etc/apache2/mods-available
RUN /bin/bash -c 'a2enmod ssl'

# Configure apache virtualhost
COPY ./etc/apache2/sites-available /etc/apache2/sites-available
RUN /bin/bash -c 'a2ensite virtualhost'

COPY ./tmp/dwl/init.sh /tmp/dwl/init.sh
