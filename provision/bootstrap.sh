#!/usr/bin/env bash
set -e

yum install epel-release -y
yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y
yum install yum-utils git svn vim net-tools wget screen daemonize zip unzip -y
yum-config-manager --enable remi-php72 -y
yum install install php php-zip php-mysqlnd php-pecl-mcrypt php-xml php-mbstring php-common php-json php-cli -y
yum install httpd mariadb mariadb-server -y
systemctl start httpd.service
systemctl enable httpd.service
systemctl start mariadb.service
systemctl enable mariadb.service
sed -i 's/SELINUX=enforcing/SELINUX=permissive/' /etc/selinux/config
setenforce 0
usermod -a -G apache  $BANDALAB_USER
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
#firewall-cmd --permanent --add-port=80/tcp
#firewall-cmd --reload  
echo "Done! Bootstrap"
