#!/bin/bash

# Requires php-cli php-zip wget unzip
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/bin/composer
chmod +x /usr/bin/composer

#su -c composer global require "laravel/installer" vagrant
#su -c echo 'export PATH="$HOME/.config/composer/vendor/bin:$PATH"'  >> ~/.bashrc vagrant

echo "Done! Composer"