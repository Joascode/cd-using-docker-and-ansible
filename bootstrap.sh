#!/bin/bash

echo "Installing required packages before installs"
apt-get install -y software-properties-common
apt-add-repository universe
apt-get update
apt-get install -y apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    python-pip \
    libseccomp2 \
    tree 

echo "Updating installed packages"
apt-get update

echo "Updating pip to latest version"
pip install --upgrade pip

# The next three steps are not mandatory and could be executed during the tutorial if needed.
echo "Install Django version 1.9"
pip install django==1.9

echo "Install virtualenv for Python"
pip install virtualenv

echo "Adding django-admin to PATH"
export PATH=$PATH:/home/vagrant/.local/bin

echo "Installing Ansible..."
apt-add-repository ppa:ansible/ansible
apt-get install -y --force-yes ansible

echo "Installing pip packages for working with AWS"
pip install boto boto3

echo "Installing AWS CLI"
pip install awscli

# echo "Removing older versions of Docker, just in case!"
# apt-get remove docker docker-engine docker.io containerd runc

echo "Installing Docker Engine"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-get install -y docker-ce containerd.io

echo "Installing docker-compose"
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Docker post install steps to make it a bit more secure
# See for more info: https://docs.docker.com/engine/install/linux-postinstall/
echo "Setting up Docker in such a way you don't need sudo to run docker commands"
sudo groupadd docker
# sudo usermod -aG docker $USER or vagrant, not sure if this evaluates to
# vagrant when running vagrant up (--provision)
sudo usermod -aG docker $USER
# Re-evaluating the group emmbership. This activates the changes made to the group.
newgrp docker

#! These steps are redundant, now that MySQL runs inside a container. Leaving it
#! here for reference.
echo "Installing MySQL"
sudo apt install -y mysql-server

echo "Setting up secure MySQL installation"
mysql -sfu root << EOF
    IF (SELECT COUNT(*) FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1')) != 0
    THEN
        UPDATE mysql.user SET authentication_string=PASSWORD('root') WHERE User='root';
        DELETE FROM mysql.user WHERE User='';
        DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
        DROP DATABASE IF EXISTS test;
        DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
        FLUSH PRIVILEGES;
    END IF;
EOF

echo "Create database in MySQL"
mysql -u root -e "CREATE DATABASE IF NOT EXISTS todobackend;"

echo "Setting up new MySQL user"
mysql -u root -e "CREATE USER IF NOT EXISTS 'todo'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';"

echo "Grant all privileges to new MySQL user"
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'todo'@'localhost' IDENTIFIED BY 'password';"

echo "Setting proper PATH for install mysql-python"
sudo apt install -y default-libmysqlclient-dev

# echo "Installing Node.js v14.x"
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs
npm install -g yarn # Yarn is required to install packages properly.
#! Remember to install npm packages with the --no-bin-links flag when inside the VM.
#! When installed with --no-bin-links, typical commands like grunt or mocha won't work. Use npx grunt or npx mocha for those scenarios.

# This isn't required, since you install this package inside the virtual environment inside the VM.
# echo "Installing required Python packages for MySQL"
# pip install mysqlclient

# Setting this Virtualenv variable avoids the OSError: [Errno 71] Protocol error
export VIRTUALENV_ALWAYS_COPY=1