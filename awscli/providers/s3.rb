action :upload do
  case node['platform_family']
    when 'rhel'
      bash 'upload_s3_file' do
        code <<-EOH
                    aws s3 cp #{new_resource.local_path} #{new_resource.s3_path}
        EOH
      end
    when 'windows'
      batch 'upload_s3_file' do
        code "C:\\PROGRA~1\\Amazon\\AWSCLI\\aws.exe s3 cp #{new_resource.local_path} #{new_resource.s3_path}"
      end
    else
      shell_out('The action is not supported in this OS')

  end
end

action :download do
  case node['platform_family']

    when 'rhel'
      bash 'download_s3_file' do
        code <<-EOH
                    aws s3 cp #{new_resource.s3_path} #{new_resource.local_path}
        EOH
      end
    when 'windows'
      batch 'download_s3_file' do
        code "\"C:\\Program Files (x86)\\Amazon\\AWSCLI\\aws.exe\" s3 cp #{new_resource.s3_path} #{new_resource.local_path}"
      end
    else
      shell_out('The action is not supported in this OS')

  end
end

action :download_if_missing do
  unless ::File.exists?(new_resource.local_path)

    case node['platform_family']
      when 'rhel'
        bash 'download_s3_file' do
          code <<-EOH
                    aws s3 cp #{new_resource.s3_path} #{new_resource.local_path}
          EOH
        end
      when 'windows'
        batch 'download_s3_file' do
          code "\"C:\\Program Files (x86)\\Amazon\\AWSCLI\\aws.exe\" s3 cp #{new_resource.s3_path} #{new_resource.local_path}"
        end
      else
        shell_out('The action is not supported in this OS')
    end
  end
end

