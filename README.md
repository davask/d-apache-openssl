# dockerfile

## Default ENV values

### Define Default LANG LOCAL
> DWL_LOCAL en_US.UTF-8

### Define username:passwd for ssh access
> DWL_USER_NAME username

> DWL_USER_PASSWD secret

### Define if ssh and sftp access are accepted
> DWL_SSH_ACCESS false

### Base activation

### Apache2 activation

### Openssl activation

> DWL_USER_DNS dev.davaskweblimited.com

> DWL_CERTBOT_EMAIL docker@davaskweblimited.com

> DWL_SSLKEY_C "EU"

> DWL_SSLKEY_ST "France"

> DWL_SSLKEY_L "Vannes"

> DWL_SSLKEY_O "davask web limited - docker container"

> DWL_SSLKEY_CN "davaskweblimited.com"

Test your encryption with this url : "https://www.ssllabs.com/ssltest/analyze.html?d=${DWL_USER_DNS}&latest" once the container is up & running

## LABEL
> dwl.server.os="ubuntu 14.04"

> dwl.server.base="ubuntu 14.04"

> dwl.server.http="apache 2.4"

> dwl.server.https="open ssl"
