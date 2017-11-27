#
# Cookbook:: ror_setup
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.


execute "ror-setup" do
  command "curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -"
end

execute "ror-setup" do
  command "curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -"
end

execute "ror-setup" do
  command 'echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list'
end

execute "ror-setup" do
  command "sudo apt-get update -y"
end

execute "ror-setup" do
  command "sudo apt-get -y install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev nodejs yarn"
end

cookbook_file "/home/ubuntu/setup.sh" do
  source "setup.sh"
  mode "0770"
end

execute "setup" do
  command "sh /home/ubuntu/setup.sh"
end

mysql_service 'mysql' do
  port '3306'
  version '5.7'
  initial_root_password 'velotio'
  action [:create, :start]
end

package 'git' do
  action :install
end

git '/home/ubuntu/sample-ror-app' do
  repository 'https://github.com/velotio-tech/sample-ror-app'
  revision 'master'
  action :sync
end

cookbook_file "/home/ubuntu/sample-ror-app/config/database.yml" do
  source "database.yml"
  mode "0644"
end

cookbook_file "/home/ubuntu/sample-ror-app/appsetup.sh" do
  source "appsetup.sh"
  mode "0770"
end


execute "setup" do
  command "sh /home/ubuntu/sample-ror-app/appsetup.sh"
end

