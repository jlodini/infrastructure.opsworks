include_recipe 'awscli'

bucketname = 'aws-codedeploy-' +  node['codedeploy']['bucket']['region']
codedeploy_msi_s3 = 's3://' + bucketname + '/latest/codedeploy-agent.msi'

directory node['tmp']['path'] do
  action :create
end

directory node['codedeploy']['path']['dir'] do
  action :create
end

awscli_s3 'codedeploy download' do
  action :download
  local_path node['codedeploy']['path']['msi']
  s3_path codedeploy_msi_s3
end

windows_package 'codedeploy-agent' do
  action :install
  source node['codedeploy']['path']['msi']
  options '/l ' + node['codedeploy']['path']['log']
end

windows_service 'codedeployagent' do
  action :start
end
