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

Chef::Log.info("******Linking Codedeploy.******")

powershell_script "Linking Codedeploy" do
 code <<-EOH
 $regionHTML = Invoke-WebRequest -Uri http://169.254.169.254/latest/meta-data/placement/availability-zone
 $region = $regionHTML.Content.Substring(0,$regionHTML.Content.Length-1)
 $HTML = Invoke-WebRequest -Uri http://169.254.169.254/latest/meta-data/instance-id
 
 Get-EC2Tag -Filter @{ res="key";Values="mytag"}
  
  EOH
  guard_interpreter :powershell_script
  not_if "(Get-WindowsFeature -Name Web-Server).Installed"
end