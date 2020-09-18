# -*- mode: ruby -*-
# vi: set ft=ruby :

# Install vagrant-disksize to allow resizing the vagrant box disk.
unless Vagrant.has_plugin?("vagrant-disksize")
  raise  Vagrant::Errors::VagrantError.new, "vagrant-disksize plugin is missing. Please install it using 'vagrant plugin install vagrant-disksize' and rerun 'vagrant up'"
end

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/bionic64"
  config.disksize.size = "60GB"
  # config.ssh.host = "10.100.199.200"
  # config.ssh.port = "22"
  # config.vm.network "forwarded_port", guest: 22, host: 2222, host_ip: "127.0.0.1", id: 'ssh'
  # if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
  #   config.vm.synced_folder "data/", "/vagrant", mount_options: ["dmode=700,fmode=600"], type: "rsync", rsync_auto: true, rsync__exclude: ".git/"
  # else
  #   config.vm.synced_folder "data/", "/vagrant", type: "rsync", rsync_auto: true, rsync__exclude: ".git/"
  # end
  # config.vm.synced_folder "data/", "/vagrant", automount: true
  config.vm.provider "virtualbox" do |v|
    v.memory = 8192
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end
  config.vm.define :dev do |dev|
    dev.vm.network "private_network", ip: "10.100.199.200"
    # This setting lets the DHCP of Virtualbox assign an IP for you.
    # You can also set a static IP, like config.vm.network "public_network", ip: "192.168.0.17"
    # Do only use 192. IP-addresses, since those are local.
    # More info at https://www.vagrantup.com/docs/networking/public_network.html
    # dev.vm.network "public_network"
    dev.vm.provision :shell, path: "bootstrap.sh"
    # dev.vm.provision :shell,
      # inline: 'PYTHONUNBUFFERED=1 ansible-playbook \
        # /vagrant/ansible/dev.yml -c local'
  end
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end
  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = false
    config.vbguest.no_install = true
    config.vbguest.no_remote = true
  end
end
