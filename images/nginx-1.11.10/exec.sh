#!/bin/bash
#
# exec.sh
#
# Developed by qindamoni <qindamoni@gmail.com>
# Copyright (c) 2017 www.qindamoni.com
#
# Changelog:
# 2017-03-22 - created

NGINX_CONF=$IMAGE_SOURCE_PATH'/nginx.conf'

TMP_NGINX_CONF=$IMAGE_SOURCE_PATH'/tmp-nginx.conf'

cp $NGINX_CONF $TMP_NGINX_CONF

PHP_CONTAINER_ID=$(docker ps | awk -v name=$PHP_IMAGE_NAME '{if($2 == name) print $1;}')

sed -i '' -e "s/%php%/${PHP_CONTAINER_ID}/" $TMP_NGINX_CONF

ACCESS_LOG=$IMAGE_SOURCE_PATH'/logs/access.log'
ERROR_LOG=$IMAGE_SOURCE_PATH'/logs/error.log'

touch $ACCESS_LOG
touch $ERROR_LOG

docker run -d \
	-v /$TMP_NGINX_CONF:/opt/work/nginx-1.11.10/conf/nginx.conf \
	-v /$ACCESS_LOG:/opt/work/nginx-1.11.10/logs/access.log \
	-v /$ERROR_LOG:/opt/work/nginx-1.11.10/logs/error.log \
	-v /$(dirname $CUR_DIR)/www/:/opt/work/www/ \
	--link=${PHP_CONTAINER_ID} \
	-p 80:80 \
	$REGISTRY_IMAGE_NAME
