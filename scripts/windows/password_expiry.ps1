# Set username
if ($env:packer_build_name.StartsWith("vagrant", 1)) {
    $username = "vagrant"
} else {
    $username = "Administrator"
}

# Disable account password expiry
wmic useraccount where "name='${username}'" set PasswordExpires=FALSE
