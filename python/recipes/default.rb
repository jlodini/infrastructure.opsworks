#
# Cookbook Name:: python
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
cookbook_file 'C:\tmp\python27.msi' do
  source 'python27.msi'
  path node['python']['msi_path']
  action :create
end

windows_package 'python' do
  action :install
  source node['python']['msi_path']
end

env "PATH" do
  value 'C:\Python27'
  delim ";"
  action :modify
end

env "PATH" do
  value 'C:\Python27\Scripts'
  delim ";"
  action :modify
end

batch 'install boto' do
  code <<-EOH
	C:\\Python27\\Scripts\\pip.exe install boto
	EOH
end
	
batch 'install boto3' do
  code <<-EOH
	C:\\Python27\\Scripts\\pip.exe install boto3
	EOH
end