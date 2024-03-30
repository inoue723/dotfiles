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
# 起動時にxremapを起動する
systemctl --user enable $HOME/.local/share/chezmoi/xremap/systemd/xremap.service

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

### gsettings
# Dockの常時表示を無効化
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
# キーリピートの設定
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 30
# キーディレイ
gsettings set org.gnome.desktop.peripherals.keyboard delay 200


### 日本語入力
sudo apt-get install -y fcitx5-mozc
# fcitx5に切り替え
im-config -n fcitx5