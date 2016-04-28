powershell_script 'Create SSMAssociation' do
code <<-EOH
 $regionHTML = Invoke-WebRequest -Uri http://169.254.169.254/latest/meta-data/placement/availability-zone
 $region = $regionHTML.Content.Substring(0,$regionHTML.Content.Length-1)
 $HTML = Invoke-WebRequest -Uri http://169.254.169.254/latest/meta-data/instance-id
 New-SSMAssociation -InstanceId $HTML.Content -Name "Join_To_AWS_OU" -region $region
EOH
end

