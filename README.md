# dockerfile

see [FROM IMAGE README.md](https://github.com/davask/d-apache2)

## Open port
- 443

## Default ENV values

### Openssl activation

> DWL_CERTBOT_EMAIL docker@davaskweblimited.com

> DWL_SSLKEY_C "EU"

> DWL_SSLKEY_ST "France"

> DWL_SSLKEY_L "Vannes"

> DWL_SSLKEY_O "davask web limited - docker container"

> DWL_SSLKEY_CN "davaskweblimited.com"

#### comments

- Test your encryption with this url : "https://www.ssllabs.com/ssltest/analyze.html?d=${DWL_USER_DNS}&latest" once the container is up & running

- The declaration of new certifications for the same domain name is 5 per 7 days

# check for Unsupported filesystem layout. sites-available/enabled expected.

## LABEL

> dwl.server.https="open ssl + certbot"
