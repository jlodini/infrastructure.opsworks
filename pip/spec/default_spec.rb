require_relative 'spec_helper'

describe 'pip::default' do
  let(:chef_run) do
    runner = ChefSpec::SoloRunner.new(
        platform: 'centos',
        version: '7.0',
    )
    env = Chef::Environment.new
    env.name 'non-prod'

    # Stub the node to return this environment
    allow(runner.node).to receive(:chef_environment).and_return(env.name)
    runner.node.default['platform_family'] = 'rhel'
    runner.converge('pip::default')

  end
  before do
    stub_data_bag_item('environment_variables', 'non-prod').and_return({'id' => 'non-prod',
                                                                        'bucket' => 'mk-aws',
                                                                        'software-packages-folder' => '/software/',
                                                                        'validation-key-file' => '/lab/common/keys/chef-validator.pem',
                                                                        'chef-client-configuration-file' => '/lab/common/scripts/client.rb'
                                                                       })

  end

  it 'should download remote file pipinstall' do
    expect(chef_run).to create_remote_file '/tmp/pipinstall.py'
  end

  it 'should run install pip command' do
    expect(chef_run).to run_bash 'install pip'
  end

  it 'should run clean bash command' do
    expect(chef_run).to run_bash 'clean'
  end


end

