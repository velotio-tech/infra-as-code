#
# Cookbook:: ror-app
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'
require 'chefspec'

ChefSpec::Coverage.start!

describe 'ror-app::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04') do |node|
      node.normal['rorapp']['port'] = 3000
      stub_command("netstat -nlt | grep 3000").and_return(false)
      stub_data_bag_item('ror_app', 'creds').and_return({
        id: 'creds',
        password: 'velotio'
      })
    end.converge(described_recipe)
  end

  it 'converges successfully' do
    expect { chef_run }.to_not raise_error
  end

  it 'installs git' do
      expect(chef_run).to install_package 'git-core'
  end

  it 'installs nodejs' do
      expect(chef_run).to install_package 'nodejs'
  end

  it 'installs  redis' do
    expect(chef_run).to install_apt_package('redis-server')
  end
  
  it 'creates a cookbook_file with an explicit action' do
      expect(chef_run).to create_cookbook_file('/home/ubuntu/sample-ror-app/config/database.yml')
  end

  it 'syncs a git with the /home/ubuntu/sample-ror-app' do
    expect(chef_run).to sync_git('/home/ubuntu/sample-ror-app')
    expect(chef_run).to_not sync_git('/home/ubuntu')
  end


  it 'creates mysql  service' do
      expect(chef_run).to create_mysql_service('mysql').with(
        version: '5.7',
        port: '3306',
        action: [:create, :start]
      )
  end
end
