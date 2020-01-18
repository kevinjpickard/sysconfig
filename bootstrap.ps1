# Enable and configure WinRM
Set-WSManQuickConfig -Force | Out-Null
winrm set winrm/config '@{MaxEnvelopeSizekb="2563000"}' | Out-Null # VS Pro Installer is 2.3 GB

# Install Chocolatey DSC Resource
Install-Module cchoco -Force

# Compile DSC Resources
. .\Windows\Configurations\Sysconfig.ps1 | Out-Null

# Apply Configuration
Start-DscConfiguration -Path .\WindowsDevConfiguration\ -Wait -Force # -Verbose
