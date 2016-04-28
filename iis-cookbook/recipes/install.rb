powershell_script "Linking Codedeploy" do
  code <<-EOH
  
  
    Install-WindowsFeature XPS-Viewer
  
  
  EOH
  guard_interpreter :powershell_script
  not_if "(Get-WindowsFeature -Name Web-Server).Installed"
end
