# BandaLab - Vagrant LAMP
Vagrant LAMP Dev Environment on CentOS7 whith PHP7.2, PhpUnit8, Node.js10.17, NPM6.11, Apache 2.4, Xdebug2.7.2, mariadb 5.5, Composer 1.9, MailHog 1.0.0 

Before moving ahead with this starter environment you'll need to have a few things installed on your computer:
* [VirtualBox](https://www.virtualbox.org/) - Free tool that allows you to run virtual machines on your computer.
* [Vagrant](https://www.vagrantup.com/) - Free tool that automates the creation of development environments within a virtual machine.

Once you've installed VirtualBox and Vagrant on your computer you're ready to continue:
1. Open a command-line (Terminal on Mac/Linux, PowerShell or Git Bash on Windows)
2. cd into this project's root folder
3. Run `vagrant up`
4. Go grab a coffee, it will take a few minutes
5. Once it completes you'll need to edit your computer's `hosts` file to point **banda.box** to our virtual machine. On Windows your host file lives in C/Windows/System32/Drivers/etc on Mac/Linux your hosts file lives in /etc
6. Add this line at the bottom of your hosts file: `192.168.33.10 banda.box`
7. Now you can visit **banda.box** in any browser.

## Database Info
An initial database is automatically created for you.

- Database name: **bandalab**
- Database user: **vagrant**
- User Password: **vagrant**
- Database hostname: **localhost**

## MailHog 
Access from http://banda.box:8025

Laravel MailHog SMTP configuration on **.env**
```
MAIL_DRIVER=smtp
MAIL_HOST=0.0.0.0
MAIL_PORT=1025
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null
```