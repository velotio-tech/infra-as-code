#!/bin/bash

cd /home/ubuntu/sample-ror-app/
#curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
#apt-get install -y nodejs
rake db:create
rake db:migrate 
rails s -d -b 0.0.0.0
