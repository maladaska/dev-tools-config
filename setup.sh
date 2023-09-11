# Setup brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

export PATH=/opt/homebrew/bin/brew:$PATH

# Install XCode Command line tools
xcode-select --install

# install python
brew install python

#install nvm
brew install nvm

# install node with nvm
brew install node


brew install neovim

# INstall Eclipse
brew install --cask eclipse-java

# Install Intellij
brew install --cask intellij-idea

#Install VS Code
brew install --cask visual-studio-code

#iterm 2
brew install --cask iterm2


# ctop container top
curl -sSl https://raw.githubusercontent.com/yadutaf/ctop/master/cgroup_top.py > /opt/ctop && python /opt/ctop

# syntax highligting for VIM
echo "syntax on" >> ~/.vimrc

#install oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install Powerlevel 10k - 
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
