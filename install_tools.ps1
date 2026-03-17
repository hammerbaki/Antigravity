$ErrorActionPreference = "Stop"

Write-Host "Downloading NVM for Windows..."
Invoke-WebRequest -Uri "https://github.com/coreybutler/nvm-windows/releases/latest/download/nvm-setup.exe" -OutFile "nvm-setup.exe"

Write-Host "Installing NVM for Windows..."
$nvmProcess = Start-Process -FilePath ".\nvm-setup.exe" -ArgumentList "/VERYSILENT" -PassThru -Wait

Write-Host "Refreshing Environment Variables..."
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Let's check where NVM actually is, usually AppData\Roaming\nvm\nvm.exe
$nvmPath = "$env:APPDATA\nvm\nvm.exe"
if (Test-Path $nvmPath) {
    Write-Host "Found NVM at $nvmPath. Installing LTS Node..."
    & $nvmPath install lts
    & $nvmPath use lts
} else {
    Write-Host "NVM not found in default location, you may need to restart the terminal and run 'nvm install lts' manually."
}

Write-Host "Downloading Git..."
Invoke-WebRequest -Uri "https://github.com/git-for-windows/git/releases/download/v2.45.1.windows.1/Git-2.45.1-64-bit.exe" -OutFile "git-setup.exe"

Write-Host "Installing Git..."
$gitProcess = Start-Process -FilePath ".\git-setup.exe" -ArgumentList "/VERYSILENT" -PassThru -Wait

Write-Host "Installation Complete."
