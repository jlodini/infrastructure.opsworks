case node['platform_family']
  when 'rhel'
    directory "/root/.aws" do
      owner 'root'
      group 'root'
      recursive true
    end
    cookbook_file 'aws.secret' do
      path "/root/.aws/config"
      action :create_if_missing
    end


  when 'linux'
      directory "%userprofile%\\.aws" do
        owner 'root'
        group 'root'
        recursive true
      end
      cookbook_file 'aws.secret' do
        path "%userprofile%\\.aws\\config"
        action :create_if_missing
      end
end