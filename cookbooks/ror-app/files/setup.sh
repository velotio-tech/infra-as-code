#!/bin/bash

cd /home/ubuntu/
wget http://ftp.ruby-lang.org/pub/ruby/2.4/ruby-2.4.2.tar.gz
tar -xzvf ruby-2.4.2.tar.gz
cd ruby-2.4.2/
./configure
make
sudo make install
ruby -v
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
gem install rails -v 5.1.4
rails -v
sudo apt-get install redis-server -y
sudo apt-get install libmysqlclient-dev -y
sudo service redis-server start
