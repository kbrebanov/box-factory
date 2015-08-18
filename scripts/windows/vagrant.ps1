$vagrant_key_url = "https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub"

# Copy vagrant public key
(New-Object System.Net.WebClient).DownloadFile($vagrant_key_url, "C:\Users\vagrant\.ssh\authorized_keys")
