#/usr/bin/env bash

branch=${1};
parentBranch=${2};
rootDir=${3};
buildDir=${4};

###########################
# portainer-template.json #
###########################

. ${ITEMPLATES}/portainer-template.sh

portainertemplate ${rootDir};
