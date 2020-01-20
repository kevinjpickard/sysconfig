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

    # cChocoPackageInstallerSet installApps {
    #   Ensure = 'Present'
    #   Name   = @(
    #     "7zip",
    #     "Firefox",
    #     "discord",
    #     "geforce-experience",
    #     "git",
    #     "golang",
    #     "GoogleChrome",
    #     "jq",
    #     "pia",
    #     "python",
    #     "slack",
    #     "sublimetext3",
    #     "sysinternals",
    #     "vagrant",
    #     "veracrypt",
    #     "virtualbox",
    #     "vlc",
    #     "vscode"
    #   )
    #   # DependsOn = "[cChocoInstaller]installChoco"
    # }

    # cChocoPackageInstaller Install_Spotify {
    #   Ensure = 'Present'
    #   Name   = 'Spotify'
    # }

    cChocoPackageInstaller Install_7Zip {
      Ensure = 'Present'
      Name   = '7zip'
    }

    cChocoPackageInstaller Install_Firefox {
      Ensure = 'Present'
      Name   = 'Firefox'
    }

    # cChocoPackageInstaller Install_Discord {
    #   Ensure = 'Present'
    #   Name   = 'Discord'
    # }

    cChocoPackageInstaller Install_GeForceExperience {
      Ensure = 'Present'
      Name   = 'geforce-experience'
    }

    cChocoPackageInstaller Install_Git {
      Ensure = 'Present'
      Name   = 'git'
    }

    cChocoPackageInstaller Install_Golang {
      Ensure = 'Present'
      Name   = 'golang'
    }

    cChocoPackageInstaller Install_GoogleChrome {
      Ensure = 'Present'
      Name   = 'GoogleChrome'
    }

    cChocoPackageInstaller Install_JQ {
      Ensure = 'Present'
      Name   = 'jq'
    }

    cChocoPackageInstaller Install_PIA {
      Ensure = 'Present'
      Name   = 'pia'
    }

    cChocoPackageInstaller Install_Python {
      Ensure = 'Present'
      Name   = 'python'
    }

    cChocoPackageInstaller Install_Slack {
      Ensure = 'Present'
      Name   = 'slack'
    }

    cChocoPackageInstaller Install_SublimeText3 {
      Ensure = 'Present'
      Name   = 'sublimetext3'
    }

    cChocoPackageInstaller Install_Sysinternals {
      Ensure = 'Present'
      Name   = 'sysinternals'
    }

    cChocoPackageInstaller Install_Vagrant {
      Ensure = 'Present'
      Name   = 'vagrant'
    }

    cChocoPackageInstaller Install_Veracrypt {
      Ensure = 'Present'
      Name   = 'veracrypt'
    }

    cChocoPackageInstaller Install_VirtualBox {
      Ensure = 'Present'
      Name   = 'virtualbox'
    }

    cChocoPackageInstaller Install_VLC {
      Ensure = 'Present'
      Name = 'vlc'
    }

    cChocoPackageInstaller Install_VSCode {
      Ensure = 'Present'
      Name = 'vscode'
    }
  }
}

Sysconfig
