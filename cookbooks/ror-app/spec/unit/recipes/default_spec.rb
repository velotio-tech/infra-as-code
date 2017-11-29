#
# Cookbook:: ror-app
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'ror-app::default' do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
    runner.converge(described_recipe)
  end

  it 'converges successfully' do
    expect { chef_run }.to_not raise_error
  end



  it 'installs git' do
      expect(chef_run).to install_package 'git'
  end

  it 'syncs a git with the /home/ubuntu/sample-ror-app' do
    expect(chef_run).to sync_git('/home/ubuntu/sample-ror-app')
    expect(chef_run).to_not sync_git('/home/ubuntu')
  end


  it 'creates mysql  service' do
      expect(chef_run).to create_mysql_service('mysql').with(
        version: '5.7',
        initial_root_password: 'velotio',
        port: '3306',
        action: [:create, :start]
      )
  end



  it 'runs a execute when specifying the identity attribute' do
    expect(chef_run).to run_execute('sh /home/ubuntu/setup.sh')
  end


  it 'runs a execute when specifying the identity attribute' do
    expect(chef_run).to run_execute('sh /home/ubuntu/sample-ror-app/appsetup.sh')
  end


end
