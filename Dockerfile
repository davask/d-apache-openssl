FROM davask/d-apache2:2.4-u14.04
MAINTAINER davask <contact@davaskweblimited.com>

RUN wget https://dl.eff.org/certbot-auto
RUN chmod a+x certbot-auto
# RUN echo 'y\n' | ./certbot-auto
# /etc/letsencrypt/accounts
# https://letsencrypt.org/documents/LE-SA-v1.0.1-July-27-2015.pdf
# RUN certbot-auto certonly --webroot -w /var/www/html -d dev.davaskweblimited.com

RUN rm -rf /var/lib/apt/lists/*


# configure tsl
RUN a2enmod ssl

RUN mkdir /etc/apache2/ssl

# RUN printf 'FR\n.\nLyon\ndavask web limited\nIT\ndavaskweblimited.com\nadmin@davaskweblimited.com\n' | openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/apache2/ssl/apache.key -out /etc/apache2/ssl/apache.crt

COPY ./sites-available /etc/apache2/sites-available
