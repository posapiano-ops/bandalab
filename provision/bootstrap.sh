#!/usr/bin/env bash
set -e

yum install epel-release -y
yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y
yum install yum-utils git svn vim net-tools wget screen daemonize zip unzip -y
yum-config-manager --disable remi-php54 -y
yum-config-manager --enable remi-php72 -y
yum install install php php-zip php-mysqlnd php-pecl-mcrypt php-xml php-mbstring php-common php-json php-cli -y
yum install httpd mariadb mariadb-server -y
systemctl start httpd.service
systemctl enable httpd.service
systemctl start mariadb.service
systemctl enable mariadb.service

# Selinux
sed -i 's/SELINUX=enforcing/SELINUX=permissive/' /etc/selinux/config
setenforce 0

#User Conf
usermod -a -G apache  $BANDALAB_USER
chmod 775 /var/www/html
chown $BANDALAB_USER.apache -R /var/www/html
chmod ug+s -R /var/www/html
find /var/www/html -type d -exec chmod 775 '{}' ';'
find /var/www/html -type f -exec chmod 664 '{}' ';'
su -c echo 'umask 0002'  >> ~/.bashrc $BANDALAB_USER

# Apache Config
cp /vagrant/etc/httpd/conf/httpd.conf .
chown root:root httpd.conf
mv -f httpd.conf /etc/httpd/conf/httpd.conf

#sed -i 's/DocumentRoot "\/var\/www\/html"/DocumentRoot "\/var\/www\/html\/public"/' /etc/httpd/conf/httpd.conf
#chown -R apache.apache -R /var/www/html

systemctl restart httpd

# Xdebug
yum install php-devel php-pear -y
pecl channel-update pecl.php.net
pecl install xdebug

cp /vagrant/etc/php.d/30-xdebug.ini .
chown root:root 30-xdebug.ini
mv 30-xdebug.ini /etc/php.d/30-xdebug.ini

systemctl restart httpd

# PHPUnit
yum --enablerepo=remi install phpunit8 -y

# Node.js
curl -sL https://rpm.nodesource.com/setup_10.x | bash -
yum install nodejs -y

# Firewall
#firewall-cmd --permanent --add-port=80/tcp
#firewall-cmd --reload  
echo "Done! Bootstrap"
