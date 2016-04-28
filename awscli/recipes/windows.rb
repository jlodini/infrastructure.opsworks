package_local_path = node['awscli']['local_package_file']['windows']

directory 'C:/tmp' do
    recursive true
end

remote_file node['awscli']['local_package_file']['windows'] do
	source 'https://s3.amazonaws.com/aws-cli/AWSCLI32.msi'
	owner 'Administrator'
	action :create
end

windows_package 'awscli' do
    action :install
    source package_local_path
end