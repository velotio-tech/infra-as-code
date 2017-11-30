# # encoding: utf-8

# Inspec test for recipe ror-app::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

#check  git is installed 

describe package('git') do
  it { should be_installed }
end

#check  ruby is installed 

describe package('ruby') do
  it { should be_installed }
end

#check  nodejs is installed 

describe package('nodejs') do
  it { should be_installed }
end

#check  redis is installed 

describe package('redis-server') do
  it { should be_installed }
end

#check database configuration file

describe file('/home/ubuntu/sample-ror-app/config/database.yml') do
 it { should exist }
end

#check md5 checksum of config file

describe file('/home/ubuntu/sample-ror-app/config/database.yml') do
  its(:md5sum) { should eq '5d9016fe6731b1d8d6f280f601b1a855' }
end

#check ruby  version

describe command('ruby -v') do
  its('stdout') { should eq "ruby 2.3.1p112 (2016-04-26) [x86_64-linux-gnu]\n" }
  its('stderr') { should eq '' }
  its('exit_status') { should eq 0 }
end

#check rails  version

describe command('rails -v') do
  its('stdout') { should eq "Rails 5.1.4\n" }
  its('stderr') { should eq '' }
  its('exit_status') { should eq 0 }
end

#check  mysql is  running on port 3306 

describe port(3306) do
  it { should be_listening }
end

#check app is running on port 3000

describe port(3000) do
  it { should be_listening }
end

#check redis is  running on port 6379

describe port(6379) do
  it { should be_listening }
end
