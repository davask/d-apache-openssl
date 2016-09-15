# dockerfile

## Default ENV values

Define Default LANG LOCAL
> DWL_LOCAL en_US.UTF-8

Define username:passwd for ssh access
> DWL_USER_NAME dwl
> DWL_USER_PASSWD dwl

Define openssl dns
> DWL_USER_DNS dev.davaskweblimited.com

## LABEL

> dwl.server.http="apache 2.4"
> dwl.server.os="ubuntu 14.04"
> dwl.server.https="open ssl"
