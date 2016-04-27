#
# Cookbook Name:: cylance
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
environment=node.chef_environment
env_variables = data_bag_item('environment_variables', environment)
cylance_x64_remote = 's3://'+ env_variables['software-bucket'] + '/cylance/' + node['cylance_setup']['cylance_version'] + '/CylanceProtect_x64.msi'
cylance_x86_remote = 's3://'+ env_variables['software-bucket'] + '/cylance/' + node['cylance_setup']['cylance_version'] + '/CylanceProtect_x86.msi'
cylance_vbs_remote = 's3://'+ env_variables['software-bucket'] + '/cylance/' + node['cylance_setup']['cylance_version'] + '/CylInst.vbs'
cylance_setup_remote = 's3://'+ env_variables['software-bucket'] + '/cylance/' + node['cylance_setup']['cylance_version'] + '/setup.exe'

cylance_x64_local = node['cylance_setup']['cylance_x64_local']
cylance_x86_local = node['cylance_setup']['cylance_x86_local']
cylance_vbs_local = node['cylance_setup']['cylance_vbs_local']
cylance_setup_local = node['cylance_setup']['cylance_setup_local']

awscli_s3 'get cylance x64' do
  action :download
  local_path cylance_x64_local
  s3_path cylance_x64_remote
end
awscli_s3 'get cylance x86' do
  action :download
  local_path cylance_x86_local
  s3_path cylance_x86_remote
end
awscli_s3 'get cylance vbs' do
  action :download
  local_path cylance_vbs_local
  s3_path cylance_vbs_remote
end
awscli_s3 'get cylance setup.exe' do
  action :download
  local_path cylance_setup_local
  s3_path cylance_setup_remote
end

batch 'execute vbs script' do
  code <<-EOH
    WScript "#{cylance_vbs_local}"
  EOH
end