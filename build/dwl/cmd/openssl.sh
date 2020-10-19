# not ready for prod
sudo mkdir -p ${APACHE_SSL_DIR:-/etc/apache2/ssl}/${1:-nodns};
sudo openssl req \
-newkey rsa:2048 -nodes -keyout ${APACHE_SSL_DIR:-/etc/apache2/ssl}/${1:-nodns}/apache.key \
-x509 -days 90 -out ${APACHE_SSL_DIR:-/etc/apache2/ssl}/${1:-nodns}/apache.crt \
-subj "/C=${DWL_SSLKEY_C:-EU}/ST=${DWL_SSLKEY_ST:-France}/L=${DWL_SSLKEY_L:-Vannes}/O=${DWL_SSLKEY_O:-davask web limited - docker container}/CN=${DWL_SSLKEY_CN:-davask.com}";
