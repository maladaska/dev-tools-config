#!/bin/sh

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
    echo "...installing python with homebrew"
    brew install python3
    python3 -m pip install --upgrade pip
}

setup_node() {
    echo "...installing nvm."
    brew install nvm
    echo "...installing node."
    brew install node
}

setup_config_defaults() {
    defaults write com.apple.Finder AppleShowAllFiles true
    killall Finder
}

setup_terminal() {
    echo "...installing iterm2."
    brew install --cask iterm2
    echo "...installing oh my zsh."
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
    # Add code to PATH in present shell and also to .zprofile
    export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
    echo 
    cat << EOF >> ~/.zprofile
# Add Visual Studio Code (code) to PATH
export PATH="$PATH"
EOF
}

setup_vscode_extensions() {
    code --install-extension vscjava.vscode-java-pack

}

setup_ides() {
    setup_eclipse
    setup_intellij
    setup_vscode
}

setup_sdkman() {
    # first install sdkman - this helps manage different versions of java and other SDKs.
    curl -s "https://get.sdkman.io" | bash
    # Above will add to .zshrc but execurting below so available in current shell
    source ~/.sdkman/bin/sdkman-init.sh 
}

setup_java() {
    setup_sdkman
    sdk install java
}

setup_misc_utils() {
    # recursive tree listing command
    brew install tree
    # simplified man pages.
    brew install tldr
    # vim replacement
    brew install neovim
    echo "syntax on" >> ~/.vimrcbre
    # top like interface for container metrics
    brew install ctop
    brew install --cask postman
    brew install maven
}