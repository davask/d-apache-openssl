#! /bin/bash

. /tmp/dwl/envvar.sh
. /tmp/dwl/user.sh
. /tmp/dwl/ssh.sh
echo ">> Ubuntu initialized";

echo ">> Base initialized";

. /tmp/dwl/activateconf.sh
echo ">> dwl conf activated";

. /tmp/dwl/openssl.sh
echo ">> Openssl initialized";

. /tmp/dwl/apache2.sh
echo ">> apache2 initialized";

. /tmp/dwl/permission.sh
echo ">> permission assigned";

. /tmp/dwl/keeprunning.sh
