#!/bin/bash

## require daemonize.x86_64

## Install mailhog
wget https://github.com/mailhog/MailHog/releases/download/v1.0.0/MailHog_linux_amd64
chmod +x MailHog_linux_amd64
chown root:root MailHog_linux_amd64
mv MailHog_linux_amd64 /usr/sbin/mailhog

## Install mailhog initd service
# wget https://raw.githubusercontent.com/geerlingguy/ansible-role-mailhog/master/templates/mailhog.init.j2
cp /vagrant/etc/init.d/mailhog.init.j2 .
chown root:root mailhog.init.j2
chmod +x mailhog.init.j2
mv mailhog.init.j2 /etc/init.d/mailhog

###  Fix the paths in the mailhog init.d file
sed -i "s/BIN={{ mailhog_install_dir }}\/mailhog/BIN=\/usr\/sbin\/mailhog/" /etc/init.d/mailhog
sed -i "s/DAEMONIZE_BIN={{ mailhog_daemonize_bin_path }}/DAEMONIZE_BIN=\/usr\/sbin\/daemonize/" /etc/init.d/mailhog

## Start mailhog
chkconfig mailhog on
service mailhog start

## PHP sendmail to mhsendmail
wget https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64
chown root:root mhsendmail_linux_amd64
chmod +x mhsendmail_linux_amd64
mv mhsendmail_linux_amd64 /usr/local/bin/mhsendmail
# Change php.ini
sed -i "s/sendmail_path = \/usr\/sbin\/sendmail -t -i/sendmail_path = \/usr\/local\/bin\/mhsendmail/" /etc/php.ini
systemctl restart httpd

echo echo "Done! MailHog http://localhost:8025"