# Enable and configure WinRM
Set-WSManQuickConfig -Force | Out-Null
# Envelope needs to be big enough for package installers from choco [~2.5GB]
winrm set winrm/config '@{MaxEnvelopeSizekb="2563000"}' | Out-Null

# Install Chocolatey DSC Resources/PackageProviders
Install-PackageProvider -Name NuGet -Force
Install-Module cchoco -Force

Try {
  $startDir = Get-Location
  Set-Location .\Windows

  # Compile DSC Resources
  . .\Configurations\Sysconfig.ps1

  # Apply Configuration
  Start-DscConfiguration -Path .\Sysconfig\ -Wait -Force -Verbose
}
Catch { }
Finally {
  Set-Location $startDir
}
