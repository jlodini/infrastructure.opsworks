#
# Cookbook Name:: iis-net
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'awscli'

env_variables = data_bag_item('environment_variables', node.chef_environment)
feature_list = node['iis_net_setup']['feature_list']
login_page_files_path = node['iis_net_setup']['login_page_files_path']
login_page_files_remote = 's3://' + env_variables['bucket'] + '/website'
aws_cli_path = node['iis_net_setup']['aws_cli_path']

#install features in feature list provided by the role
feature_list.each do |feature|
  windows_feature feature do
    action :install
	all true
  end
end

#create directory
directory login_page_files_path do
  recursive true
  action :create
end

#add files from a bucket defined by the environment to the defined path
node['iis_net_setup']['login_page_files'].each do |page|

  page_url = login_page_files_remote + '/' + page
  local_cmd_path = login_page_files_path + '\\' + page
  
  batch 'get login page files' do
	not_if { File.exist?(local_cmd_path)}
	code <<-EOH
      #{aws_cli_path} s3 cp #{page_url} #{local_cmd_path}
	EOH
  end
end

#Remove default iis site
iis_site 'Default Web Site' do
  action [:stop, :delete]
end

#New iis app pool with Net 4.5
iis_pool 'Default' do
  runtime_version '4.0.30319' #translates to 4.5
  action [:add, :config]
end

#New site with app pool named 'Default'
iis_site 'Default' do
  application_pool 'Default'
  protocol :http
  port 80
  path login_page_files_path
  action [:add, :start]
end

#Adding an application to the 'Default' app pool
iis_app 'Default' do
  application_pool 'Default'
  path '/Login'
  physical_path login_page_files_path
  action :add
end
