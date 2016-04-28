require_relative 'spec_helper'

describe 'awscli::linux' do
  context 'rhel' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new(
          platform: 'centos',
          version: '7.0',
      )
      env = Chef::Environment.new
      env.name 'non-prod'

      # Stub the node to return this environment
      allow(runner.node).to receive(:chef_environment).and_return(env.name)
      runner.converge('awscli::linux')


    end
    before do
      stub_data_bag_item('environment_variables', 'non-prod').and_return({'id' => 'non-prod',
                                                                          'bucket' => 'mk-aws',
                                                                          'software-packages-folder' => '/software/',
                                                                          'validation-key-file' => '/lab/common/keys/chef-validator.pem',
                                                                          'chef-client-configuration-file' => '/lab/common/scripts/client.rb'
                                                                         })

    end

    it 'should include pip recipe' do
      expect(chef_run).to include_recipe('pip')
    end

    it 'should run pip install awscli' do
      expect(chef_run).to run_bash('awscli install')
    end

  end
end