#!/bin/bash

cd /home/ubuntu/sample-ror-app/

gem install mysql2 -v '0.4.10'

bundle install
rake db:create
rake db:migrate 
rails s -d -b 0.0.0.0 
