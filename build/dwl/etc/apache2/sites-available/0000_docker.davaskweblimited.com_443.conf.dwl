<VirtualHost *:443>

    # ServerAdmin

    # ServerName
    # ServerAlias

    # DocumentRoot

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined

    <IfModule mod_ssl.c>

        SSLEngine on
        SSLProxyEngine On

        # SSLCertificateFile
        # SSLCertificateKeyFile
        # SSLCertificateChainFile

        <FilesMatch "\.(cgi|shtml|phtml|php)$">
            SSLOptions +StdEnvVars
        </FilesMatch>

        <Directory /usr/lib/cgi-bin>
            SSLOptions +StdEnvVars
        </Directory>

        BrowserMatch "MSIE [2-6]" \
            nokeepalive ssl-unclean-shutdown \
            downgrade-1.0 force-response-1.0
        BrowserMatch "MSIE [17-9]" ssl-unclean-shutdown

    </IfModule>

    # ProxyPass
    # ProxyPassReverse
    # ProxyPassReverseCookieDomain

</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
