# Set 64bit flag
$is_64bit = [IntPtr]::size -eq 8

# Set username
if ($env:packer_build_name.StartsWith("vagrant", 1)) {
    $username = "vagrant"
} else {
    $username = "Administrator"
}

# Download and install 7Zip so that we can extract the ISO.
if ($is_64bit) {
    $sevenzip_url = "http://downloads.sourceforge.net/sevenzip/7z920-x64.msi"
} else {
    $sevenzip_url = "http://downloads.sourceforge.net/sevenzip/7z920.msi"
}
(New-Object System.Net.WebClient).DownloadFile($sevenzip_url, "C:\Windows\Temp\7zip.msi")
Start-Process "C:\Windows\System32\msiexec.exe" "/qb /i C:\Windows\Temp\7zip.msi" -NoNewWindow -Wait

if ($env:packer_builder_type -eq "virtualbox-iso") {
    # Trust Oracle certificate in order to perform silent install
    C:\Windows\System32\certutil.exe -addstore -f "TrustedPublisher" a:\oracle-cert.cer
    # Move the VirtualBox guest additions ISO to temp folder and extract
    Move-Item "C:\Users\${username}\VBoxGuestAdditions.iso" "C:\Windows\Temp\VBoxGuestAdditions.iso"
    C:\Program` Files\7-Zip\7z.exe x C:\Windows\Temp\VBoxGuestAdditions.iso -oC:\Windows\Temp\virtualbox
    # Install tools
    Start-Process "C:\Windows\Temp\virtualbox\VBoxWindowsAdditions.exe" "/S" -NoNewWindow -Wait
    # Delete files
    Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "C:\Windows\Temp\virtualbox"
    Remove-Item -Force -ErrorAction SilentlyContinue "C:\Windows\Temp\VBoxGuestAdditions.iso"
} elseif ($env:packer_builder_type -eq "vmware-iso") {
    # Move the VMware tools ISO to temp folder and extract
    Move-Item "C:\Users\${username}\windows.iso" "C:\Windows\Temp"
    C:\Program` Files\7-Zip\7z.exe x C:\Windows\Temp\windows.iso -oC:\Windows\Temp\vmware
    # Install tools
    Start-Process "C:\Windows\Temp\vmware\setup.exe" '/S /v "/qn REBOOT=R"' -NoNewWindow -Wait
    # Delete files
    Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "C:\Windows\Temp\vmware"
    Remove-Item -Force -ErrorAction SilentlyContinue "C:\Windows\Temp\windows.iso"
}

# Uninstall 7Zip
Start-Process "C:\Windows\System32\msiexec.exe" "/qb /x C:\Windows\Temp\7zip.msi" -NoNewWindow -Wait

# Delete 7Zip download
Remove-Item -Force -ErrorAction SilentlyContinue "C:\Windows\Temp\7zip.msi"
