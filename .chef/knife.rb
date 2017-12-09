log_level                :info
log_location             STDOUT
node_name                'chefadmin'
client_key               '/var/lib/jenkins/workspace/build/.chef/chefadmin.pem'
#validation_client_name   'shortname-validator'
#validation_key           '/home/centos/.chef/velotio-validator.pem'
chef_server_url          'https://ec2-34-226-123-132.compute-1.amazonaws.com/organizations/4thcoffee'
syntax_check_cache_path  '/var/lib/jenkins/workspace/build/.chef/syntax_check_cache'
cookbook_path [ '/var/lib/jenkins/workspace/build/cookbooks' ]
