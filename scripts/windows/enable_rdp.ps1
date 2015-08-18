$RDP = Get-WmiObject -Class Win32_TerminalServiceSetting -Namespace root\CIMV2\TerminalServices -Computer $env:computername -Authentication 6 -ErrorAction Stop

$RDP.SetAllowTSConnections(1,1)

# Disable NLA (Network Level Authentication)
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name UserAuthentication -Value "0"

# Enable RDP thru firewall
Enable-NetFirewallRule -DisplayName "Remote Desktop - Shadow (TCP-In)"
Enable-NetFirewallRule -DisplayName "Remote Desktop - User Mode (TCP-In)"
