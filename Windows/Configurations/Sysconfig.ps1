Configuration Sysconfig
{
  param
  (
    [string[]]$ComputerName = 'localhost'
  )

  Import-DscResource -ModuleName PSDesiredStateConfiguration
  Import-DscResource -ModuleName cChoco

  Node $ComputerName
  {
    LocalConfigurationManager {
      DebugMode = 'ForceModuleImport'
    }

    cChocoInstaller installChoco {
      InstallDir = "c:\choco"
    }

    cChocoPackageInstallerSet installOtherDevDependencies {
      Ensure    = 'Present'
      Name      = @(
        "7zip",
        "Firefox",
        "Spotify",
        "discord",
        "geforce-experience",
        "git",
        "golang",
        "jq",
        "pia",
        "python",
        "slack",
        "sublimetext3",
        "sysinternals",
        "vagrant",
        "veracrypt",
        "virtualbox",
        "vlc",
        "vscode"
      )
      DependsOn = "[cChocoInstaller]installChoco"
      AutoUpgrade = $True
    }
  }
}

Sysconfig
