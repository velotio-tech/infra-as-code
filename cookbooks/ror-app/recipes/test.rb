ruby_runtime '2'
ruby_gem 'rake'

git '/home/ubuntu/sample-ror-app' do
  repository 'https://github.com/velotio-tech/sample-ror-app'
  revision 'master'
  action :sync
end

application '/home/ubuntu/sample-ror-app' do
  puma do
    port 3000
  end
end
