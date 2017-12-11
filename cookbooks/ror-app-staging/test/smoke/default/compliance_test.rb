# # encoding: utf-8

# Inspec test for recipe ror-app::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/


#check port 80 not open

describe port(80) do
  it { should_not be_listening }
end

#check ssl port is open 

describe port(5000) do
  it { should be_listening }
  its('protocols') {should eq ['tcp']}
end

#check ssh no password

describe sshd_config do
  its('PasswordAuthentication') { should cmp('no') }
end

#check ssl cipher

describe ssl(port: 443).ciphers(/rc4/i) do
  it { should_not be_enabled }
end

#check ssl protocol

describe ssl(port: 443).protocols('ssl2') do
  it { should_not be_enabled }
end
