#
# Cookbook:: ror-app
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

apt_update 'update'
ruby_runtime '2'
ruby_gem 'rake'
ruby_gem 'bundler'
package 'build-essential'
package 'git-core'
package 'curl'
package 'zlib1g-dev'
package 'libssl-dev'
package 'libreadline-dev'
package 'libyaml-dev'
package 'libsqlite3-dev'
package 'sqlite3'
package 'libxml2-dev'
package 'libxslt1-dev'
package 'libcurl4-openssl-dev'
package 'libffi-dev'
package 'libmysqlclient-dev'
ruby_gem 'rails'



mysql_service 'mysql' do
  port '3306'
  version '5.7'
  initial_root_password 'velotio'
  action [:create, :start]
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

bundle_install '/home/ubuntu/sample-ror-app/Gemfile' do
  deployment true
end

include_recipe "nodejs::nodejs_from_package"

apt_package 'redis-server' do
  action :install
end

service 'redis-server' do
  action [ :enable, :start ]
end

script 'run_app' do
  interpreter 'bash'
  user 'root'
  cwd '/home/ubuntu/sample-ror-app'
  code <<-EOH
  rake db:create
  rake db:migrate
  rails s -d -b 0.0.0.0
  EOH
#not_if { ::File.exist?('/tmp/lockfile') }
not_if ("netstat -nlt | grep 3000")

end
