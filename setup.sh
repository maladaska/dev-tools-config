

setup_brew() {
    echo "...installing homebrew (and xcode command line tools if required)"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Add to path now so that other functions from this script will work.
    export PATH=/opt/homebrew/bin/brew:$PATH 
    # Add Homebrew to your PATH in ~/.zprofile:
    (echo; echo 'eval "$(/usr/local/bin/brew shellenv)"') >> /Users/ad378529/.profile
    eval "$(/usr/local/bin/brew shellenv)"
}

setup_python() {
    # install python
    echo "...installing python with homebrew"
    brew install python
}

setup_node() {
    echo "installing nvm."
    #install nvm
    brew install nvm
    # install node with nvm
    echo "...installing node."
    brew install node

}

setup_finder_defaults() {
    defaults write com.apple.Finder AppleShowAllFiles true
    killall Finder
}

setup_terminal() {
    #iterm 2
    echo "...installing iterm2."
    brew install --cask iterm2
    #install oh my zsh
    echo "...installing oh my zsh."
    # Install Powerlevel 10k - Doing this in different order to what would normally be expected as installer
    # changes shell which prevents rest of script being executed.
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

}
setup_powerlevel10k_theme() {
    brew install powerlevel10k
    echo "source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" >> ~/.zshrc
}


setup_eclipse() {
    brew install --cask eclipse-jee
}

setup_intellij() {
    brew install --cask intellij-idea
}
setup_vscode() {
    brew install --cask visual-studio-code
}
# brew install neovim



# # ctop container top
# curl -sSl https://raw.githubusercontent.com/yadutaf/ctop/master/cgroup_top.py > /opt/ctop && python /opt/ctop

# # syntax highligting for VIM
# echo "syntax on" >> ~/.vimrcbre