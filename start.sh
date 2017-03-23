#!/bin/bash -x
#
# start.sh
#
# Developed by qindamoni <qindamoni@gmail.com>
# Copyright (c) 2017 www.qindamoni.com
#
# Changelog:
# 2017-03-14 - created

CUR_DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}"  )" && pwd  )" 

source $CUR_DIR'/lib/common.sh'

if [ $# -lt 1 ]; then
	print_error "missing argument #1"
fi

IMAGE_NAME=$1;
IMAGE_PATH=$CUR_DIR'/images/'$IMAGE_NAME;
IMAGE_EXEC=$IMAGE_PATH'/exec.sh';
IMAGE_SOURCE_PATH=$IMAGE_PATH'/source';
IMAGE_DOCKERFILE=$IMAGE_PATH'/Dockerfile';

REGISTRY_HOST="qindamoni.com:5000/qindamoni"
REGISTRY_IMAGE_NAME=$REGISTRY_HOST'/'$IMAGE_NAME

check_path $IMAGE_PATH
check_file $IMAGE_EXEC

image_exist $REGISTRY_IMAGE_NAME

if [ "0" != "$?" ];then
	if [ "$2" = "-f" ];then
		remove_image $REGISTRY_IMAGE_NAME

		docker pull $REGISTRY_IMAGE_NAME
	fi
else
	docker pull $REGISTRY_IMAGE_NAME
fi

remove_container $REGISTRY_IMAGE_NAME

source $IMAGE_EXEC
