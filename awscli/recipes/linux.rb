include_recipe 'pip'

bash 'awscli install' do
    code <<-EOH
        pip install awscli
    EOH
end