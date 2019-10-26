# -*- mode: ruby -*-
# vi: set ft=ruby :

# read configurable cpu/memory/port/swap/host/edition settings from environment variables
memory = ENV['GITLAB_MEMORY'] || 1024
cpus = ENV['BANDALAB_CPUS'] || 2
port = ENV['BANDALAB_PORT'] || 8443
swap = ENV['BANDALAB_SWAP'] || 0
host = ENV['BANDALAB_HOST'] || "Bandalab.local"
edition = ENV['BANDALAB_EDITION'] || "community"
private_network = ENV['BANDALAB_PRIVATE_NETWORK'] || 0
user= ENV['BANDALAB_USER'] || "vagrant"

Vagrant.require_version ">= 1.8.0"


Vagrant.configure("2") do |config|

  config.vm.define :bandalab do |config|
    config.vm.hostname = host
    config.vm.box = "centos/7"
    config.vm.provision :shell, :path => "provision/bootstrap.sh", env: { "BANDALAB_USER" => user, "BANDALAB_HOSTNAME" => host }
    config.vm.provision :shell, :path => "provision/mysql_secure.sh" 
    config.vm.provision :shell, :path => "provision/composer.sh"
    config.vm.provision :shell, :path => "provision/mailhog.sh" 

    config.vm.network "private_network", ip: "192.168.33.10"
    
    config.vm.synced_folder ".", "/vagrant", disabled: false

    if Vagrant.has_plugin? 'vagrant-winnfsd'
      config.vm.synced_folder ".", "/vagrant",
        nfs: true,
        mount_options: [
        'nfsvers=3',
        'vers=3',
        'actimeo=1',
        'rsize=8192',
        'wsize=8192',
        'timeo=14'
        ]
    else
      config.vm.synced_folder ".", "/vagrant", :mount_options => ["dmode=777", "fmode=666"]
    end
  end

  config.vm.provider "virtualbox" do |vb|
    vb.cpus = cpus
    vb.memory = memory
  end

  # NFS PLUGIN https://github.com/winnfsd/vagrant-winnfsd
  # https://stefanwrobel.com/how-to-make-vagrant-performance-not-suck
  #config.vm.synced_folder "./public" , "/var/www/html", type: "nfs" , :mount_options => ["dmode=777", "fmode=666"]

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   yum update
  #   yum install -y git
  # SHELL
end
