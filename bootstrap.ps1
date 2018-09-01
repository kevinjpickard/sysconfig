# Install Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install and setup docker
choco install -y docker-toolbox
docker-machine create default
docker-machine start default
docker-machine env | Invoke-Expression

# Build Ansible Docker image
docker build .

# Run Ansible playbook

