# Setup brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install pip
python get-pip.py

#install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

# install node with nvm
nvm install node # "node" is an alias for the latest version
brew install node


brew install neovim

# ctop container top
curl -sSl https://raw.githubusercontent.com/yadutaf/ctop/master/cgroup_top.py > /opt/ctop && python /opt/ctop

# syntax highligting for VIM
echo "syntax on" >> ~/.vimrc

#install oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install Powerlevel 10k - 
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

