#!/usr/bin/bash

# install zsh
sudo apt-get install -y zsh
# defaultのshellをzshに変更
sudo sed -i.bak "s|$HOME:/bin/bash|$HOME:/bin/zsh|" /etc/passwd

# antigen
curl -L git.io/antigen > antigen.zsh

# mise (pakage manager)
curl https://mise.run | sh
