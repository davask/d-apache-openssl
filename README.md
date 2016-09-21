# dockerfile

see [FROM IMAGE README.md](https://github.com/davask/d-apache2-openssl)

## Open port
- 443

## Default ENV values

### Certbot activation

> DWL_CERTBOT_EMAIL docker@davaskweblimited.com

#### comments

- Test your encryption with this url : "https://www.ssllabs.com/ssltest/analyze.html?d=${DWL_USER_DNS}&latest" once the container is up & running

- The declaration of new certifications for the same domain name is 5 per 7 days

## LABEL

> dwl.server.certificat="certbot"
