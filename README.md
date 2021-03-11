# Expand Azure VM OS Drive
<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fthomasnli%2Fexpand-azure-vm-os-drive-demo%2Fmain%2Fazure_vm_deploy.json" target="_blank">
  <img src="https://aka.ms/deploytoazurebutton"/>
</a>

## Overview
This is a demo to show the process of expanding the C partition of an Azure VM with the help of an ARM template to deploy the demo environment quickly. The process of expanding the VM's disk and expanding the OS volume of the VM is also automated by PowerShell. 

### 1. Hit the “Deploy to Azure” button to set up the demo environment automatically
By hitting the "Deploy to Azure" button above, a VM provision process in your Azure portal will be initiated by the associated ARM template. On your Azure portal, please provide the "Resource group", "Virtual Machine name", "Admin Username" and "Admin Password" and hit the "Create" button for Azure to create the VM with 128G OS volume and associated resource. A VM extension is also included in the ARM template as part of the VM provision to create a PowerShell shortcut inside the VM for the OS volume expand.  

three clicks to deploy teh demo enviorment:
![Deploy VM Step1](https://github.com/thomasnli/expand-azure-vm-os-drive-demo/blob/main/images/deploy_vm_step1.png)
VM,Vnet and other associated resources are created automatically:
![Deploy VM Step2](https://github.com/thomasnli/expand-azure-vm-os-drive-demo/blob/main/images/deploy_vm_step2.png)
A 128G OS disk was created for the VM:
![Deploy VM Step3](https://github.com/thomasnli/expand-azure-vm-os-drive-demo/blob/main/images/deploy_vm_step3.png)
Check the volume inside the VM:
![Deploy VM Step4](https://github.com/thomasnli/expand-azure-vm-os-drive-demo/blob/main/images/deploy_vm_step4.png)





### 2. Copy and run below PowerShell command inside the Azure portal to resize the VM disk to 200G

```powershell
$rgName = Read-Host -Prompt "Enter the name of the resource group of the VM"
$vmName = Read-Host -Prompt "Enter the name of the VM for a larger disk"
$vm = Get-AzVM -ResourceGroupName $rgName -Name $vmName
Stop-AzVM -ResourceGroupName $rgName -Name $vmName
$disk= Get-AzDisk -ResourceGroupName $rgName -DiskName $vm.StorageProfile.OsDisk.Name
$disk.DiskSizeGB = 200
Update-AzDisk -ResourceGroupName $rgName -Disk $disk -DiskName $disk.Name
Start-AzVM -ResourceGroupName $rgName -Name $vmName
```

![Resize Disk Step1](https://github.com/thomasnli/expand-azure-vm-os-drive-demo/blob/main/images/resize_disk_step1.png)
![Resize Disk Step2](https://github.com/thomasnli/expand-azure-vm-os-drive-demo/blob/main/images/resize_disk_step2.png)
![Resize Disk Step3](https://github.com/thomasnli/expand-azure-vm-os-drive-demo/blob/main/images/resize_disk_step3.png)

### 3. Login to the VM to expand the volume 
As part of the VM provision process, a PowerShell script to expand the OS volume was created on the desktop already. We just need to double click to run the script. A Disk Management console will be opened to show the change while a PowerShell console expands the C volume. 

![Expand Volumn Step1](https://github.com/thomasnli/expand-azure-vm-os-drive-demo/blob/main/images/expand_volume_step1.png)
![Expand Volumn Step2](https://github.com/thomasnli/expand-azure-vm-os-drive-demo/blob/main/images/expand_volume_step2.png)

### 4. Copy and run below PowerShell command inside the Azure portal to remove the demo environment
```powershell
$rgName = Read-Host -Prompt "Enter the name of the resource group to remove"
Remove-AzureRmResourceGroup -Name $rgName
````

**To sum up: generally speaking, this is a similar process applies to VM running in Hyper-V, VMware: expand the VM disk from hypervisor level and expand the OS volume inside the VM with the help of Disk Management console**
