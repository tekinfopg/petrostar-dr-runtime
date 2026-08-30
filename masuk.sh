#!/bin/bash
set -e
mkdir -p /run/php /var/log/apache2
service php8.1-fpm start
service php8.2-fpm start
echo "PHP 8.1: $(php8.1 -v | head -1)"
echo "PHP 8.2: $(php8.2 -v | head -1)"
exec apache2ctl -D FOREGROUND
