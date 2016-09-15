#! /bin/bash

# declare user
if [ "`grep ${DWL_USER_NAME} /etc/passwd | wc -l`" = 0 ]; then
    echo ">> Declare user ${DWL_USER_NAME}";
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
    chown -R ${DWL_USER_NAME}:${DWL_USER_NAME} -R ${DWL_USER_HOME}
fi

if [ "${DWL_INIT}" != "data" ]; then
    DWL_KEEP_RUNNING=true
    echo ">> configure certbot";
    # certbot-auto --apache -d ${DWL_USER_DNS};
    echo "test your encryption with this url : https://www.ssllabs.com/ssltest/analyze.html?d=${DWL_USER_DNS}&latest"
    echo ">> Ssh started";
    service ssh start;
    echo ">> Sendmail started";
    service sendmail start;
    echo ">> Apache2 started";
    service apache2 start;
fi
echo "Ubuntu initialized";

if [ "${DWL_KEEP_RUNNING}" = "true" ]; then
    echo "> KEEP RUNNING ACTIVE";
    tail -f /dev/null;
fi
