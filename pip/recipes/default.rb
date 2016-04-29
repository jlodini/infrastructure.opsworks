if platform?('rhel') or platform?('centos') or platform?('redhat')

    remote_file '/tmp/pipinstall.py' do
        source 'https://bootstrap.pypa.io/get-pip.py'
    end


    bash 'install pip' do
        code <<-EOH
            python /tmp/pipinstall.py
        EOH
    end

    bash 'clean' do
        code <<-EOH
            rm /tmp/pipinstall.py
        EOH
    end

end