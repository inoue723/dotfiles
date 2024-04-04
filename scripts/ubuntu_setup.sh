#!/usr/bin/zsh

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
# fcitxを自動起動
mkdir -p ~/.config/autostart && cp /usr/share/applications/org.fcitx.Fcitx5.desktop ~/.config/autostart

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

### github cli
sudo mkdir -p -m 755 /etc/apt/keyrings && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y

### font
wget https://github.com/miiton/Cica/releases/download/v5.0.3/Cica_v5.0.3.zip
unzip Cica_v5.0.3.zip -d Cica
mkdir -p .local/share/fonts && cp Cica/Cica-* "$_"
rm -rf Cica Cica_v5.0.3.zip

### 
sudo apt-get install -y chrome-gnome-shell

### workspaceの設定
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 5
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Ctrl>1']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Ctrl>2']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Ctrl>3']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Ctrl>4']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5 "['<Ctrl>5']"

### super + numberでアプリ切り替えを無効化
gsettings set org.gnome.shell.extensions.dash-to-dock hot-keys false