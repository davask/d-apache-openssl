#/usr/bin/env bash

branch=${1};
parentBranch=${branch};

if [[ "${branch}" != "2.4-u12.04" ]] && [[ "${branch}" != "2.4-u14.04" ]] && [[ "${branch}" != "2.4-u16.04" ]]; then

    echo "Apache available: 2.4-u12.04, 2.4-u14.04, 2.4-u16.04"
    exit 0;

fi

thisDir=`readlink -m "${PWD}"`;
rootDir="${thisDir}";
buildDir=`readlink -m "${thisDir}/build"`;

. ./script/Dockerfile.sh ${branch} ${parentBranch} ${rootDir} ${buildDir}
. ./script/README.sh ${branch} ${parentBranch} ${rootDir} ${buildDir}
. ./script/docker-compose.sh ${branch} ${parentBranch} ${rootDir} ${buildDir}

sudo docker build -t davask/d-apache-openssl:${branch} ${thisDir};

echo "sudo docker run --name d-apache-openssl -tdi -p 65500:80/tcp -p 65502:22/tcp -p 65503:443/tcp --label io.rancher.scheduler.affinity:host_label=dwl=dwlComPrivate davask/d-apache-openssl:${branch}";
echo "http://public.ginkgo-migration.com:6408/env/1a5/apps/add-service?environmentId=&containerId=";

exit 1;
