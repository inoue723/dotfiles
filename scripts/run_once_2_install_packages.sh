### Install Docker
# ref. https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository
sudo apt-get install -y \
    ca-certificates \
    curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Use docker command without sudo
sudo groupadd docker
sudo usermod -aG docker $USER


### Vscode
curl -L "https://go.microsoft.com/fwlink/?LinkID=760868" -o vscode.deb
sudo apt-get install -y ./vscode.deb && rm ./vscode.deb

### Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt-get install -y ./google-chrome-stable_current_amd64.deb && rm ./google-chrome-stable_current_amd64.deb


### 1password
wget https://downloads.1password.com/linux/debian/amd64/stable/1password-latest.deb
sudo apt-get install -y ./1password-latest.deb && rm ./1password-latest.deb

### font
wget https://github.com/miiton/Cica/releases/download/v5.0.3/Cica_v5.0.3.zip
unzip Cica_v5.0.3.zip -d Cica
mkdir -p .local/share/fonts && cp Cica/Cica-* "$_"
rm -rf Cica Cica_v5.0.3.zip

