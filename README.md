# d-apache2-openssl
dockerfile base for openssl

Default ENV values

Define Default LANG LOCAL
> DWL_LOCAL en_US.UTF-8

- - -

Force container to keep running
> DWL_KEEP_RUNNING false

Define username:passwd for ftp access
> DWL_USER_NAME dwl
> DWL_USER_PASSWD dwl

Define dirname to receive app files
> DWL_APP_DIR files

Define instantiation type
> DWL_INIT app

- - -

Define APACHE FDQN
> DWL_FQDN davaskweblimited.com
