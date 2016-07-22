FROM davask/d-apache2:2.4-u14.04
MAINTAINER davask <contact@davaskweblimited.com>

# configure tsl
RUN a2enmod ssl

COPY ./sites-available /etc/apache2/sites-available
