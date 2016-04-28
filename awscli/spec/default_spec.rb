require_relative 'spec_helper'

describe 'awscli::default' do
  let(:chef_run) do
    runner = ChefSpec::SoloRunner.new(
        platform: 'centos',
        version: '7.0',
    )
    env = Chef::Environment.new
    env.name 'non-prod'

    # Stub the node to return this environment
    allow(runner.node).to receive(:chef_environment).and_return(env.name)
    runner.node.set['awscli']['pip_install'] = true
    runner.converge('awscli::default')


  end
  before do
    stub_data_bag_item('environment_variables', 'non-prod').and_return({'id' => 'non-prod',
                                                                        'bucket' => 'mk-aws',
                                                                        'software-packages-folder' => '/software/',
                                                                        'validation-key-file' => '/lab/common/keys/chef-validator.pem',
                                                                        'chef-client-configuration-file' => '/lab/common/scripts/client.rb'
                                                                       })

  end

  it 'should include linux recipe' do

    expect(chef_run).to include_recipe('awscli::linux')
  end


end

