# cookbook/libraries/matchers.rb

if defined?(ChefSpec)
  def download_s3_file(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:awscli_s3, :download, resource_name)
  end

  def upload_s3_file(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:awscli_s3, :upload, resource_name)
  end

  def download_if_missing_s3_file(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:awscli_s3, :download_if_missing, resource_name)
  end

  def install_windows_package(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:windows_package, :install, resource_name)
  end
end