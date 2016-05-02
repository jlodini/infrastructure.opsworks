powershell_script 'deploy CodeDeploy' do
code <<-EOH
New-Item c:\temp PowerShell -type directory
Invoke-WebRequest -Uri https://s3-us-west-2.amazonaws.com/aws-codedeploy-us-west-2/latest/codedeploy-agent.msi -Outfile c:\temp\codedeployagent.msi
c:\temp\codedeployagent.msi /quiet /l c:\temp\host-agent-install-log.txt
$HTML = Invoke-WebRequest -Uri http://169.254.169.254/latest/meta-data/instance-id
$instanceId =$HTML.Content
$regionHTML = Invoke-WebRequest -Uri http://169.254.169.254/latest/meta-data/placement/availability-zone
$region = $regionHTML.Content.Substring(0,$regionHTML.Content.Length-1)
$tags=Get-EC2Tag -region us-west-2 -Filter @{name="key";Values="opsworks:stack"} | Where-Object {$_.ResourceId -eq $instanceId}
Update-CDDeploymentGroup -region us-west-2 -ApplicationName $tags.Value -CurrentDeploymentGroupName $tags.Value
Restart-Service -Name codedeployagent
EOH
end

