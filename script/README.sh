#/usr/bin/env bash

branch=${1};
parentBranch=${2};
rootDir=${3};
buildDir=${4};

#############
# README.md #
#############

echo "# dockerfile

see [FROM IMAGE README.md](https://github.com/davask/d-apache)

## Open port

- 443

## Default ENV values

### Openssl activation

> DWL_SSLKEY_C \"EU\"

> DWL_SSLKEY_ST \"France\"

> DWL_SSLKEY_L \"Vannes\"

> DWL_SSLKEY_O \"davask web limited - docker container\"

> DWL_SSLKEY_CN \"davaskweblimited.com\"

## virtualhost automatic conf

> # ServerAdmin

> # DocumentRoot

> # ServerName

> # ServerAlias

> # SSLCertificateFile

> # SSLCertificateKeyFile

## LABEL

> dwl.server.http=\"openssl\"
" > ${rootDir}/README.md

echo "README.md generated with apache-openssl:${branch}";
