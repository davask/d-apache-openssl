if [ "`find /etc/lestencrypt/live/${DWL_USER_DNS} -type f &> /dev/null | wc -l`" = "0" ]; then
    echo "> configure certbot AKA let's encrypt";
    certbot-auto \
        --non-interactive --agree-tos \
        --email ${DWL_CERTBOT_EMAIL} \
         --apache \
         --webroot-path /var/www/html \
         --domains "${DWL_USER_DNS}";

    echo "> add certbot renewal as a cron task";
    crontab -l > file;
    echo '30 2 * * 1 /usr/local/bin/certbot-auto renew --quiet --no-self-upgrade >> /var/log/letsencrypt/le-renew.log' >> file
    crontab file;

    service apache2 reload;

else
    echo "> trigger certbot renewal";
    certbot-auto renew
fi
