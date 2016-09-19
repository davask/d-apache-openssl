#! /bin/bash

# declare user
if [ "`grep ${DWL_USER_NAME} /etc/passwd | wc -l`" = 0 ]; then
    echo "> Declare user ${DWL_USER_NAME}";
    # declare home user
    DWL_USER_HOME=/home/${DWL_USER_NAME};
    # declare group user
    groupadd -r ${DWL_USER_NAME};
    # declare group user
    useradd -m -r \
        -g ${DWL_USER_NAME} \
        -G ${DWL_ADMIN_GROUP} \
        -d ${DWL_USER_HOME} \
        -s /bin/bash \
        -c "dwl ssh user" \
        -p $(echo "${DWL_USER_PASSWD}" | openssl passwd -1 -stdin) \
        ${DWL_USER_NAME};
    chown -R ${DWL_USER_NAME}:${DWL_USER_NAME} -R ${DWL_USER_HOME};
fi

if [ "${DWL_SSH_ACCESS}" = "true" ]; then
    DWL_KEEP_RUNNING=true;
    echo "> Start Ssh";
    service ssh start;
fi
echo ">> Ubuntu initialized";

echo ">> Base initialized";

if [ "`find ${APACHE_SSL_DIR} -type d -name "${DWL_USER_DNS}" | wc -l`" = "0" ]; then
    echo "> configure ssl";
    mkdir -p ${APACHE_SSL_DIR}/${DWL_USER_DNS};
    chmod 700 ${APACHE_SSL_DIR}/${DWL_USER_DNS};
    openssl req \
       -newkey rsa:2048 -nodes -keyout ${APACHE_SSL_DIR}/${DWL_USER_DNS}/apache.key \
       -x509 -days 90 -out ${APACHE_SSL_DIR}/${DWL_USER_DNS}/apache.crt \
       -subj "/C=${DWL_SSLKEY_C}/ST=${DWL_SSLKEY_ST}/L=${DWL_SSLKEY_L}/O=${DWL_SSLKEY_O}/CN=${DWL_SSLKEY_CN}";
    sed -i "s|# SSLCertificateFile|SSLCertificateFile ${APACHE_SSL_DIR}/${DWL_USER_DNS}/apache.crt|g" /etc/apache2/sites-enabled/${DWL_USER_APACHE_CONF}.conf;
    sed -i "s|# SSLCertificateKeyFile|SSLCertificateKeyFile ${APACHE_SSL_DIR}/${DWL_USER_DNS}/apache.key|g" /etc/apache2/sites-enabled/${DWL_USER_APACHE_CONF}.conf;
fi

if [ "`find ${CERTBOT_LIVE_DIR}/${DWL_USER_DNS} -type f &> /dev/null | wc -l`" = "0" ]; then
    echo "> configure certbot AKA let's encrypt";
    certbot-auto --non-interactive --agree-tos --email ${DWL_CERTBOT_EMAIL} \
         --apache --webroot-path /var/www/html --domains "${DWL_USER_DNS}";

    echo "> add certbot renewal as a cron task";
    crontab -l > file;
    echo '30 2 * * 1 /usr/local/bin/certbot-auto renew --quiet --no-self-upgrade >> /var/log/letsencrypt/le-renew.log' >> file
    crontab file;
else
    echo "> trigger certbot renewal";
    certbot-auto renew
fi

echo ">> Openssl initialized";

if [ -d ${DWL_USER_HOME}/files ]; then
    rm -rdf /var/www/html;
    ln -sf ${DWL_USER_HOME}/files /var/www/html;
fi
service apache2 start;

echo ">> apache2 initialized";

if [ "${DWL_KEEP_RUNNING}" = "true" ]; then
    echo "> Kept container active";
    tail -f /dev/null;
fi
