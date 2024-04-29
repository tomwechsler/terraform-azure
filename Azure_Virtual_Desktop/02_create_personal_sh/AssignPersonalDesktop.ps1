# Use these commands to assign a desktop to a user
# If you're not already logged in
Add-AzAccount
Get-AzSubscription -SubscriptionName "SUB_NAME" | Select-AzSubscription

# Get the name of the Desktop Application Group
$DagName = terraform output -raw desktop_application_group_name
$DagRGName = terraform output -raw desktop_application_group_resource_group

# Assign
$UserUPN = "SET_ME" # Ex. AdGodin@contosohq.xyz
New-AzRoleAssignment -SignInName $UserUPN `
  -RoleDefinitionName "Desktop Virtualization User" `
  -ResourceName $DagName -ResourceGroupName $DagRGName `
  -ResourceType 'Microsoft.DesktopVirtualization/applicationGroups'