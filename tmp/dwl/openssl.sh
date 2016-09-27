for DWL_USER_DNS in `echo ${DWL_DNS_TOPROCESS[*]}`; do

  DWL_USER_DNS_CONF=/etc/apache2/sites-available/${DWL_USER_DNS}.conf

  echo "> configure ssl for ${DWL_USER_DNS} with path ${DWL_USER_DNS_CONF}";

  if [ ! -d ${APACHE_SSL_DIR}/${DWL_USER_DNS} ]; then
      mkdir -p ${APACHE_SSL_DIR}/${DWL_USER_DNS};
      chmod 700 ${APACHE_SSL_DIR}/${DWL_USER_DNS};
  fi

  if [ "`find ${APACHE_SSL_DIR}/${DWL_USER_DNS} -type f | wc -l`" = "0" ]; then

    echo ">> Generate ssl for ${DWL_USER_DNS}";

    if [ "$((`echo ${DWL_USER_DNS} | sed 's/[^\.]//g' | wc -c` -1 ))" != 1 ]; then

      echo "Generate ssl for top domain + domain";

      DWL_USER_DNS_SERVERNAME=`echo "${DWL_USER_DNS}" | awk -F '[\.]' '{print $(NF-1)"."$NF}'`;

      sed -i "s|# ServerName|ServerName ${DWL_USER_DNS_SERVERNAME}|g" ${DWL_USER_DNS_CONF};

      sed -i "s|# ServerAlias|ServerAlias ${DWL_USER_DNS}|g" ${DWL_USER_DNS_CONF};

      sed -i "s|# SSLCertificateFile|SSLCertificateFile ${APACHE_SSL_DIR}/${DWL_USER_DNS}/apache.crt|g" ${DWL_USER_DNS_CONF};

      sed -i "s|# SSLCertificateKeyFile|SSLCertificateKeyFile ${APACHE_SSL_DIR}/${DWL_USER_DNS}/apache.key|g" ${DWL_USER_DNS_CONF};

    else

      echo "Generate ssl for domain";

      sed -i "s|# ServerName|ServerName ${DWL_USER_DNS}|g" ${DWL_USER_DNS_CONF};

      sed -i "s|# SSLCertificateFile|SSLCertificateFile ${APACHE_SSL_DIR}/${DWL_USER_DNS}/apache.crt|g" ${DWL_USER_DNS_CONF};

      sed -i "s|# SSLCertificateKeyFile|SSLCertificateKeyFile ${APACHE_SSL_DIR}/${DWL_USER_DNS}/apache.key|g" ${DWL_USER_DNS_CONF};

    fi

    openssl req \
       -newkey rsa:2048 -nodes -keyout ${APACHE_SSL_DIR}/${DWL_USER_DNS}/apache.key \
       -x509 -days 90 -out ${APACHE_SSL_DIR}/${DWL_USER_DNS}/apache.crt \
       -subj "/C=${DWL_SSLKEY_C}/ST=${DWL_SSLKEY_ST}/L=${DWL_SSLKEY_L}/O=${DWL_SSLKEY_O}/CN=${DWL_SSLKEY_CN}";

  fi

done;
