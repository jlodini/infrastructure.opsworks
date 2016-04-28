require_relative 'spec_helper'

describe 'awscli::windows' do
  context 'windows' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new(
          platform: 'windows',
          version: '2012',
      )
      env = Chef::Environment.new
      env.name 'non-prod'

      # Stub the node to return this environment
      allow(runner.node).to receive(:chef_environment).and_return(env.name)
      runner.converge('awscli::windows')


    end
    before do
      stub_data_bag_item('environment_variables', 'non-prod').and_return({'id' => 'non-prod',
                                                                          'bucket' => 'mk-aws',
                                                                          'software-packages-folder' => '/software/',
                                                                          'validation-key-file' => '/lab/common/keys/chef-validator.pem',
                                                                          'chef-client-configuration-file' => '/lab/common/scripts/client.rb'
                                                                         })

    end

    it 'should create the temp directory' do
      expect(chef_run).to create_directory('C:/tmp')
    end

    it 'should install windows package awscli' do
      expect(chef_run).to install_windows_package('awscli')
    end

  end
end