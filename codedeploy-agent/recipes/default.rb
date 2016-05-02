powershell_script 'deploy' do
code <<-EOH
New-Item c:\temp2 -type directory
Invoke-WebRequest -Uri https://s3-us-west-2.amazonaws.com/aws-codedeploy-us-west-2/latest/codedeploy-agent.msi -Outfile c:\temp2\codedeployagent.msi
c:\temp\codedeployagent.msi /quiet /l c:\temp\host-agent-install-log.txt
$HTML = Invoke-WebRequest -Uri http://169.254.169.254/latest/meta-data/instance-id
$instanceId =$HTML.Content
$regionHTML = Invoke-WebRequest -Uri http://169.254.169.254/latest/meta-data/placement/availability-zone
$region = $regionHTML.Content.Substring(0,$regionHTML.Content.Length-1)
$tags=Get-EC2Tag -region us-west-2 -Filter @{name="key";Values="opsworks:stack"} | Where-Object {$_.ResourceId -eq $instanceId}
$list = Get-CDApplicationRevisionList -ApplicationName $tags.Value -region us-west-2 | Select-Object -first 1
New-CDDeployment -region us-west-2 -ApplicationName $tags.Value -DeploymentGroupName $tags.Value -S3Location_Bucket $list.S3Location.Bucket -S3Location_Key $list.S3Location.Key -S3Location_BundleType $list.S3Location.BundleType -S3Location_ETag $list.S3Location.ETag -Revision_RevisionType S3
EOH
end

