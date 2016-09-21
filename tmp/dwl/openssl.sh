if [ "`find ${APACHE_SSL_DIR} -type d -name "${DWL_USER_DNS}" | wc -l`" = "0" ] || [ "`find ${APACHE_SSL_DIR}/${DWL_USER_DNS} -type f | wc -l`" = "0" ]; then

    echo "> configure ssl";

    mkdir -p ${APACHE_SSL_DIR}/${DWL_USER_DNS};
    chmod 700 ${APACHE_SSL_DIR}/${DWL_USER_DNS};

    openssl req \
       -newkey rsa:2048 -nodes -keyout ${APACHE_SSL_DIR}/${DWL_USER_DNS}/apache.key \
       -x509 -days 90 -out ${APACHE_SSL_DIR}/${DWL_USER_DNS}/apache.crt \
       -subj "/C=${DWL_SSLKEY_C}/ST=${DWL_SSLKEY_ST}/L=${DWL_SSLKEY_L}/O=${DWL_SSLKEY_O}/CN=${DWL_SSLKEY_CN}";

    sed -i "s|# ServerName|ServerName `echo ${DWL_USER_DNS}`|g" /etc/apache2/sites-available/${DWL_USER_DNS}.conf;
    sed -i "s|# SSLCertificateFile|SSLCertificateFile `echo ${APACHE_SSL_DIR}/${DWL_USER_DNS}`/apache.crt|g" /etc/apache2/sites-available/${DWL_USER_DNS}.conf;
    sed -i "s|# SSLCertificateKeyFile|SSLCertificateKeyFile `echo ${APACHE_SSL_DIR}/${DWL_USER_DNS}`/apache.key|g" /etc/apache2/sites-available/${DWL_USER_DNS}.conf;

fi
