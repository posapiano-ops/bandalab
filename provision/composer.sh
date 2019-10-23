#!/bin/bash

# Requires php-cli php-zip wget unzip
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/bin/composer
chmod +x /usr/bin/composer

echo "Done! Composer"