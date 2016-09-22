for conf in `find /etc/apache2/sites-available -type f -name "*.conf"`; do

  DWL_USER_DNS=`echo ${conf} | awk -F '[/]' '{print $5}' | sed "s|\.conf||g"`;
  echo ${DWL_USER_DNS};

  if [ ! -d ${APACHE_SSL_DIR}/${DWL_USER_DNS} ]; then
      mkdir -p ${APACHE_SSL_DIR}/${DWL_USER_DNS};
      chmod 700 ${APACHE_SSL_DIR}/${DWL_USER_DNS};
  fi

  if [ "`find ${APACHE_SSL_DIR}/${DWL_USER_DNS} -type f | wc -l`" = "0" ]; then
    echo "> configure ssl";

    openssl req \
       -newkey rsa:2048 -nodes -keyout ${APACHE_SSL_DIR}/${DWL_USER_DNS}/apache.key \
       -x509 -days 90 -out ${APACHE_SSL_DIR}/${DWL_USER_DNS}/apache.crt \
       -subj "/C=${DWL_SSLKEY_C}/ST=${DWL_SSLKEY_ST}/L=${DWL_SSLKEY_L}/O=${DWL_SSLKEY_O}/CN=${DWL_SSLKEY_CN}";

    if [ "$((`echo "${DWL_USER_DNS}" | sed 's/[^\.]//g' | wc -c` -1 ))" != 1 ]; then

      DWL_USER_DNS_SERVERNAME=`echo "${DWL_USER_DNS}" | awk -F '[\.]' '{print $(NF-1)"."$NF}'`;

      sed -i "s|# ServerName|ServerName ${DWL_USER_DNS_SERVERNAME}|g" \
          /etc/apache2/sites-available/${DWL_USER_DNS}.conf;

      sed -i "s|# ServerAlias|ServerAlias ${DWL_USER_DNS}|g" \
          /etc/apache2/sites-available/${DWL_USER_DNS}.conf;

      sed -i "s|# SSLCertificateFile|SSLCertificateFile ${APACHE_SSL_DIR}/${DWL_USER_DNS_SERVERNAME}/apache.crt|g" \
          /etc/apache2/sites-available/${DWL_USER_DNS}.conf;

      sed -i "s|# SSLCertificateKeyFile|SSLCertificateKeyFile ${APACHE_SSL_DIR}/${DWL_USER_DNS_SERVERNAME}/apache.key|g" \
          /etc/apache2/sites-available/${DWL_USER_DNS}.conf;
    else
      sed -i "s|# ServerName|ServerName ${DWL_USER_DNS}|g" \
          /etc/apache2/sites-available/${DWL_USER_DNS}.conf;
      sed -i "s|# SSLCertificateFile|SSLCertificateFile ${APACHE_SSL_DIR}/${DWL_USER_DNS}/apache.crt|g" \
          /etc/apache2/sites-available/${DWL_USER_DNS}.conf;
      sed -i "s|# SSLCertificateKeyFile|SSLCertificateKeyFile ${APACHE_SSL_DIR}/${DWL_USER_DNS}/apache.key|g" \
          /etc/apache2/sites-available/${DWL_USER_DNS}.conf;
    fi
  fi

done;
