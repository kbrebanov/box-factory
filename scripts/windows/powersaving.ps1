# Set power saving to High Performance
C:\Windows\System32\powercfg.exe -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

# Disable monitor timeout
C:\Windows\System32\powercfg.exe -Change -monitor-timeout-ac 0
C:\Windows\System32\powercfg.exe -Change -monitor-timeout-dc 0
