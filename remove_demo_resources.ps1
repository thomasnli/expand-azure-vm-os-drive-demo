$rgName = Read-Host -Prompt "Enter the name of the resource group to remove"
Remove-AzureRmResourceGroup -Name $rgName