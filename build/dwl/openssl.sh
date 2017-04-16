#! /bin/bash

for conf in `find /etc/apache2/sites-available -type f -name "*.conf"`; do

    DWL_USER_DNS_CONF=${conf};

    DWL_USER_DNS_DATA=`echo ${DWL_USER_DNS_CONF} | awk -F '[/]' '{print $5}' | sed "s|\.conf||g"`;

    DWL_USER_DNS=`echo ${DWL_USER_DNS_DATA} | awk -F '[_]' '{print $2}'`;
    DWL_USER_DNS_PORT=`echo ${DWL_USER_DNS_DATA} | awk -F '[_]' '{print $3}'`;
    DWL_USER_DNS_PORT_CONTAINER=`echo ${DWL_USER_DNS_DATA} | awk -F '[_]' '{print $1}'`;
    DWL_USER_DNS_SERVERNAME=`echo "${DWL_USER_DNS}" | awk -F '[\.]' '{print $(NF-1)"."$NF}'`;

    if [ "$DWL_USER_DNS_PORT" == "443" ]; then

        echo "> configure openssl virtualhost for ${DWL_USER_DNS} with path ${DWL_USER_DNS_CONF}";

        if [ ! -d ${APACHE_SSL_DIR}/${DWL_USER_DNS} ]; then
            mkdir -p ${APACHE_SSL_DIR}/${DWL_USER_DNS};
            chmod 700 ${APACHE_SSL_DIR}/${DWL_USER_DNS};
        fi

        if [ "`find ${APACHE_SSL_DIR}/${DWL_USER_DNS} -type f | wc -l`" = "0" ]; then

            echo ">> Generate ssl for ${DWL_USER_DNS}";

            . ${dwlDir}/virtualhost.sh "${DWL_USER_DNS}" "${DWL_USER_DNS_CONF}" "${DWL_USER_DNS_SERVERNAME}"

            sed -i "s|# SSLCertificateFile|SSLCertificateFile ${APACHE_SSL_DIR}/${DWL_USER_DNS}/apache.crt|g" ${DWL_USER_DNS_CONF};

            sed -i "s|# SSLCertificateKeyFile|SSLCertificateKeyFile ${APACHE_SSL_DIR}/${DWL_USER_DNS}/apache.key|g" ${DWL_USER_DNS_CONF};

            openssl req \
                -newkey rsa:2048 -nodes -keyout ${APACHE_SSL_DIR}/${DWL_USER_DNS}/apache.key \
                -x509 -days 90 -out ${APACHE_SSL_DIR}/${DWL_USER_DNS}/apache.crt \
                -subj "/C=${DWL_SSLKEY_C}/ST=${DWL_SSLKEY_ST}/L=${DWL_SSLKEY_L}/O=${DWL_SSLKEY_O}/CN=${DWL_SSLKEY_CN}";

        fi
    fi

done;
