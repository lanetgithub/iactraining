# Connect to Azure
Connect-AzAccount

#Specify a single Subscription ID
$SubscriptionID  = "YoursubscriptionID"

# Set Current Subscription
$context = Get-AzSubscription -SubscriptionID $SubscriptionID
Set-AzContext $context
Write-Output "Context Selected" $context

$ResourceGroupName = "RG-UKS-TRAINING"

# Example 1 - Simple SQL Server
# New-AzResourceGroup -Name $ResourceGroupName -Location $location
$TemplateFile = "C:\Temp\Training\SQL\SQLServer.Template.json"
$ParameterFile = "C:\Temp\Training\SQL\SQLServer.Parameters.json"

$Timestamp =  Get-Date -format "yyyyMMdd-HHmm"
New-AzResourceGroupDeployment -Name Deploy-$Timestamp -TemplateFile $TemplateFile -TemplateParameterFile $ParameterFile -ResourceGroupName $ResourceGroupName

# Example 2 - SQL Server with Database
$TemplateFile = "C:\Devops\Training\Training2\SQL\SQLServerWithDatabase.json"
$ParameterFile = "C:\Devops\Training\Training2\SQL\SQLServerWithDB.Parameters.json"

$Timestamp =  Get-Date -format "yyyyMMdd-HHmm"
New-AzResourceGroupDeployment -Name Deploy-$Timestamp -TemplateFile $TemplateFile -TemplateParameterFile $ParameterFile -ResourceGroupName $ResourceGroupName

# blank deploy
$TemplateFile = "C:\Devops\Training\Training2\SQL\blankdemo.json"
$ParameterFile = "C:\Devops\Training\Training2\SQL\blankdemo.parameters.json"

$Timestamp =  Get-Date -format "yyyyMMdd-HHmm"
New-AzResourceGroupDeployment -Name Deploy-$Timestamp -TemplateFile $TemplateFile -TemplateParameterFile $ParameterFile -ResourceGroupName $ResourceGroupName

# Log Analytics Account
$TemplateFile = "C:\Devops\Training\Training2\SQL\newtemplate.json"
$ParameterFile = "C:\Devops\Training\Training2\SQL\newtemplate.parameters.json"

$Timestamp =  Get-Date -format "yyyyMMdd-HHmm"
New-AzResourceGroupDeployment -Name Deploy-$Timestamp -TemplateFile $TemplateFile -TemplateParameterFile $ParameterFile -ResourceGroupName $ResourceGroupName
