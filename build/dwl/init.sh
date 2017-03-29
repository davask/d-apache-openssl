#! /bin/bash

dwlDir="/dwl";

. ${dwlDir}/envvar.sh
. ${dwlDir}/user.sh
. ${dwlDir}/ssh.sh

echo ">> Ubuntu initialized";

echo ">> Base initialized";

. ${dwlDir}/permission.sh
echo ">> permission assigned";

. ${dwlDir}/activateconf.sh
echo ">> dwl conf activated";

. ${dwlDir}/openssl.sh
echo ">> Openssl initialized";

. ${dwlDir}/apache2.sh
echo ">> apache2 initialized";

. ${dwlDir}/keeprunning.sh
