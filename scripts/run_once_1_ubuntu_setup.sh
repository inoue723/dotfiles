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