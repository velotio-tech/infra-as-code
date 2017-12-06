#
# Cookbook:: ror-app
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'
require 'chefspec'

describe 'ror-app::default' do
  let(:chef_run) do
    runner = ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04')
    stub_data_bag_item('ror_app', 'creds').and_return({
      id: 'creds',
      password: 'velotio'
   })

    runner.converge(described_recipe)
  end

  it 'converges successfully' do
    stub_command("netstat -nlt | grep 3000").and_return(false)
    expect { chef_run }.to_not raise_error
  end

  it 'installs git' do
      stub_command("netstat -nlt | grep 3000").and_return(false)
      expect(chef_run).to install_package 'git-core'
  end

  it 'installs nodejs' do
      stub_command("netstat -nlt | grep 3000").and_return(false)
      expect(chef_run).to install_package 'nodejs'
  end

  it 'installs  redis' do
    stub_command("netstat -nlt | grep 3000").and_return(false)
    expect(chef_run).to install_apt_package('redis-server')
  end
  
  it 'creates a cookbook_file with an explicit action' do
      stub_command("netstat -nlt | grep 3000").and_return(false)
      expect(chef_run).to create_cookbook_file('/home/ubuntu/sample-ror-app/config/database.yml')
  end

  it 'syncs a git with the /home/ubuntu/sample-ror-app' do
    stub_command("netstat -nlt | grep 3000").and_return(false)
    expect(chef_run).to sync_git('/home/ubuntu/sample-ror-app')
    expect(chef_run).to_not sync_git('/home/ubuntu')
  end


  it 'creates mysql  service' do
      stub_command("netstat -nlt | grep 3000").and_return(false)
      expect(chef_run).to create_mysql_service('mysql').with(
        version: '5.7',
        initial_root_password: 'velotio',
        port: '3306',
        action: [:create, :start]
      )
  end
end
