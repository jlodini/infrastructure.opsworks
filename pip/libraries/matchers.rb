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

  def configure_elastic_search_configure_iis_certificates(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:elastic_search_configure_iis_certificates, :configure, resource_name)
  end
  def install_elastic_search_install(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:elastic_search_install, :install, resource_name)
  end
end