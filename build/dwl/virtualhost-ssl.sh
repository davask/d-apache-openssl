#! /bin/bash

for conf in `sudo find /etc/apache2/sites-available -type f -name "*.conf"`; do

    . ${dwlDir}/vhost-env.sh;

    if [ "$DWL_USER_DNS_PORT" == "443" ]; then
        echo "> configure virtualhost-ssl for ${DWL_USER_DNS} with path ${DWL_USER_DNS_CONF}";
        if [ ! -f "/etc/letsencrypt/live/${DWL_USER_DNS}/cert.pem" ] \
        && [ -f "${APACHE_SSL_DIR}/${DWL_USER_DNS}/apache.key" ]; then

            echo "Update SSL Certificat public key for domain";
            sudo sed -i "s|# SSLCertificateFile|SSLCertificateFile ${APACHE_SSL_DIR}/${DWL_USER_DNS}/apache.crt|g" ${DWL_USER_DNS_CONF};

        fi
        if [ ! -f "/etc/letsencrypt/live/${DWL_USER_DNS}/privkey.pem" ] \
        && [ -f "${APACHE_SSL_DIR}/${DWL_USER_DNS}/apache.crt" ]; then

            echo "Update SSL Certificat private key for domain";
            sudo sed -i "s|# SSLCertificateKeyFile|SSLCertificateKeyFile ${APACHE_SSL_DIR}/${DWL_USER_DNS}/apache.key|g" ${DWL_USER_DNS_CONF};

        fi
    fi

done;

