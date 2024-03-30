# ディレクトリを英語にする
LANG=C xdg-user-dirs-gtk-update

# git, curlをインストール
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get install -y git curl

# Rustをインストール
sudo apt-get install -y gcc
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | \
    sh -s -- -y
source "$HOME/.cargo/env"

# install xremap
cargo install xremap --features gnome

# start xremap automatically on boot
sudo cp $HOME/ubuntu-setup/xremap/xremap.service /etc/systemd/system/
sudo systemctl enable xremap.service

# Install Docker
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