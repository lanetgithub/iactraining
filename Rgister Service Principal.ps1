# Pre Req's
# Ensure you have the AzureAD and Azure PowerShell modules installed.
    # If not then open PowerShell as admin and run :  Install-Module -Name az -AllowClobber -Scope AllUsers
    # And - install-module AzureAD
    # This allows for the use of unsigned scripts if prompted about this
    # set-executionpolicy Unrestricted
# Check / change the password
# This script will setup a DevOps Service Principal in Azure AD and assign it owner access to Management Groups or Resource Group/s.
# The SP can be removed from the Management Group / RGs and deleted from Azure AD when no longer required.

# If not logged in run this.
Connect-AzAccount

# Root Management Group ID 
$RootManagementGroupID = "Root-Management-Group"
$SubID = "YourSubID"
$DevRGName = "RG-UKS-DEV-TRAINING"
$PrdRGName = "RG-UKS-PRD-TRAINING"
$SPName = "Training2AzureDevOpsServicePrincipal"
$Password = "chooseapassword"

# Create the SP
$credentials = New-Object -TypeName Microsoft.Azure.Commands.ActiveDirectory.PSADPasswordCredential -Property @{
    StartDate=Get-Date; EndDate=Get-Date -Year 2024; Password=$Password }
$sp = New-AzAdServicePrincipal -DisplayName $SPName -PasswordCredential $credentials

Write-Output "SP Application ID required for DevOps is : "
$sp.ApplicationId

# Assign the SP Permissions to the Management Group
Start-Sleep 10 # wait for SP to be built properly.
$sp = Get-AzADServicePrincipal -DisplayName $SPName
New-AzRoleAssignment -ApplicationId $sp.ApplicationId -RoleDefinitionName "Contributor" -Scope "/providers/Microsoft.Management/managementGroups/$RootManagementGroupID"

# Assign to Dev resource group
$sp = Get-AzADServicePrincipal -DisplayName $SPName
New-AzRoleAssignment -ApplicationId $sp.ApplicationId -RoleDefinitionName "Contributor" -Scope "/subscriptions/$SubID/resourceGroups/$DevRGName"

# Assign to Prod resource group
$sp = Get-AzADServicePrincipal -DisplayName $SPName
New-AzRoleAssignment -ApplicationId $sp.ApplicationId -RoleDefinitionName "Contributor" -Scope "/subscriptions/$SubID/resourceGroups/$PrdRGName"

