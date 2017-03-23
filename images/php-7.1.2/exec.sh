#!/bin/bash
#
# exec.sh
#
# Developed by qindamoni <qindamoni@gmail.com>
# Copyright (c) 2017 www.qindamoni.com
#
# Changelog:
# 2017-03-22 - created

PHP_FPM_CONF=$IMAGE_SOURCE_PATH'/php-fpm.conf'
PHP_INI=$IMAGE_SOURCE_PATH'/php.ini'

TMP_PHP_FPM_CONF=$IMAGE_SOURCE_PATH'/.tmp-php-fpm.conf'
TMP_PHP_INI=$IMAGE_SOURCE_PATH'/.tmp-php.ini'

if [ -e $TMP_PHP_FPM_CONF  ];then
    rm $TMP_PHP_FPM_CONF
fi

if [ -e $TMP_PHP_INI ];then
    rm $TMP_PHP_INI
fi

cp $PHP_FPM_CONF $TMP_PHP_FPM_CONF
cp $PHP_INI $TMP_PHP_INI

PHP_FPM_LOG=$IMAGE_SOURCE_PATH'/logs/php-fpm.log'
PHP_ERROR_LOG=$IMAGE_SOURCE_PATH'/logs/error.log'
PHP_SLOW_LOG=$IMAGE_SOURCE_PATH'/logs/slow.log'

docker run -d\
	-v $TMP_PHP_FPM_CONF:/opt/work/php-7.1.2/etc/php-fpm.conf \
	-v $TMP_PHP_INI:/opt/work/php-7.1.2/lib/php.ini \
	-v $PHP_FPM_LOG:/opt/work/php-7.1.2/var/log/php-fpm.log \
	-v $PHP_ERROR_LOG:/opt/work/php-7.1.2/var/log/error.log \
	-v $PHP_SLOW_LOG:/opt/work/php-7.1.2/var/log/slow.log \
    -v $(dirname $CUR_DIR):/opt/work/www \
	-p 9000 \
	$REGISTRY_IMAGE_NAME
