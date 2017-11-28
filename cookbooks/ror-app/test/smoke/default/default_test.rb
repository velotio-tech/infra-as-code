# # encoding: utf-8

# Inspec test for recipe ror-app::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/


#check  git is installed 

describe package('git') do
  it { should be_installed }
end


#check  mysql is  running on port 3306 

describe port(3306) do
  it { should be_listening }
end

#check app is running on port 3000

describe port(3000) do
  it { should be_listening }
end

#check ruby is installed and version

describe command('ruby -v') do
  its('stdout') { should eq "ruby 2.4.2p198 (2017-09-14 revision 59899) [x86_64-linux]\n" }
  its('stderr') { should eq '' }
  its('exit_status') { should eq 0 }
end

#check rails is installed and version

describe command('rails -v') do
  its('stdout') { should eq "Rails 5.1.4\n" }
  its('stderr') { should eq '' }
  its('exit_status') { should eq 0 }
end

#check redis is  running on port 6379

describe port(6379) do
  it { should be_listening }
end
