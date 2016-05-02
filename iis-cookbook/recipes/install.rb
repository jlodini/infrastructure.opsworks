powershell_script "Linking Codedeploy" do
  code <<-EOH
Import-Module ServerManager 
Add-WindowsFeature -Name Web-Server
  
  
  EOH
  guard_interpreter :powershell_script
  not_if "(Get-WindowsFeature -Name Web-Server).Installed"
end
