#!/usr/bin/env bash

# Make sure that NOBODY can access the server without a password
mysql -e "UPDATE mysql.user SET Password = PASSWORD('CHANGEME') WHERE User = 'root'"
# Kill the anonymous users
mysql -e "DROP USER ''@'localhost'"
# Because our hostname varies we'll use some Bash magic here.
mysql -e "DROP USER ''@'$(hostname)'"
# Disable root remote access
mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1')"
# Kill off the demo database
mysql -e "DROP DATABASE test"
# Create Database bandalab
mysql -e "CREATE DATABASE bandalab"
# Create Vagrant user
mysql -e "CREATE USER 'vagrant'@'%' IDENTIFIED BY 'vagrant'" 
mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'vagrant'@'%' WITH GRANT OPTION"
# Make our changes take effect
mysql -e "FLUSH PRIVILEGES"

# Any subsequent tries to run queries this way will get access denied because lack of usr/pwd param
# mkdir -p /home/vagrant/bin
cat > /home/vagrant/.my.cnf << EOF
[client]
user=vagrant
password=vagrant
host=localhost
EOF

chmod 0600 /home/vagrant/.my.cnf

echo "Done! MysqlSecure"