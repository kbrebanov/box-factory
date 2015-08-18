# Enable and configure WinRM
Enable-PSRemoting -Force
Set-Item "WSMan:\localhost\MaxTimeoutms" "1800000"
Set-Item "WSMan:\localhost\Shell\MaxMemoryPerShellMB" "1024"
Set-Item "WSMan:\localhost\Service\AllowUnencrypted" "true"
Set-Item "WSMan:\localhost\Service\Auth\Basic" "true"
Set-Item "WSMan:\localhost\Service\Auth\CredSSP" "true"
Set-Item "WSMan:\localhost\Client\Auth\Basic" "true"

# Change WinRM startup type from Automatic (Delayed) to Automatic
Stop-Service WinRM
Set-Service WinRM -StartupType "Automatic"
Start-Service WinRM

# Enable WinRM thru firewall
Enable-NetFirewallRule -DisplayName "Windows Remote Management (HTTP-In)"
