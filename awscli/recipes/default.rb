install_through_msi = node['awscli']['msi_install']
install_through_pip = node['awscli']['pip_install']
if platform?('windows') and install_through_msi
    include_recipe 'awscli::windows'
elsif (platform?('rhel') or platform?('centos') or platform?('redhat')) and install_through_pip
    include_recipe 'awscli::linux'
end
