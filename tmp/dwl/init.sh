#! /bin/bash

. /tmp/dwl/user.sh
. /tmp/dwl/ssh.sh
echo ">> Ubuntu initialized";

echo ">> Base initialized";

. /tmp/dwl/openssl.sh
echo ">> Openssl initialized";

. /tmp/dwl/apache2.sh
echo ">> apache2 initialized";

. /tmp/dwl/keeprunning.sh
