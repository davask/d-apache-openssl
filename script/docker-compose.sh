#/usr/bin/env bash

branch=${1};
parentBranch=${2};
rootDir=${3};
buildDir=${4};

######################
# docker-compose.yml #
######################

echo "d-apache:
  ports:
  - 65500:80/tcp
  - 65502:22/tcp
  - 65503:443/tcp
  environment:
    DWL_LOCAL: en_US.UTF-8
    DWL_USER_ID: '1000'
    DWL_USER_PASSWD: secret
    DWL_LOCAL_LANG: en_US:en
    DWL_USER_NAME: username
    DWL_SSH_ACCESS: 'true'
    DWL_SHIELD_HTTP: 'false'
    DWL_SSLKEY_C: EU
    DWL_SSLKEY_ST: France
    DWL_SSLKEY_L: Vannes
    DWL_SSLKEY_O: davask web limited - docker container
    DWL_SSLKEY_CN: davaskweblimited.com
  image: davask/d-apache-openssl:${branch}
  hostname: localhost
  net: bridge
  volumes:
  - ${buildDir}/etc/apache2/ssl:/etc/apache2/ssl
  - ${rootDir}/volumes/proxy/log/localhost/apache2:/var/log/apache2
  - ${rootDir}/volumes/home/username/http/app/sites-available:/etc/apache2/sites-available
  - ${rootDir}/volumes/home/username/files:/home/username/files
  working_dir: /var/www/html
" > ${rootDir}/docker-compose.yml

echo "docker-compose.yml generated with apache:${branch}";
