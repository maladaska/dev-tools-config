#!/bin/sh

setup_brew() {
    echo "...installing homebrew (and xcode command line tools if required)"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Add to path now so that other functions from this script will work.
    HOMEBREW_PREFIX=`brew --prefix`
    export PATH=$HOMEBREW_PREFIX/bin/brew:$PATH 
    cat << EOF >> ~/.zshrc
# Add homebrew  to Path
export PATH=$HOMEBREW_PREFIX/bin/brew:\$PATH
EOF
    source . ~/.zshrc
    echo "PATH updated: $PATH"
}

setup_python() {
    echo "...installing python with homebrew"
    brew install python3 --force
    python3 -m pip install --upgrade pip
}

setup_node() {
    echo "...installing nvm."
    brew install nvm --force
    echo "...installing node."
    brew install node
}


setup_config_defaults() {
    defaults write com.apple.Finder AppleShowAllFiles true
    killall Finder
}

setup_terminal() {
    echo "...installing iterm2."
    brew install --cask iterm2 --force
    echo "...installing oh my zsh."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    
    brew install zsh-autocomplete --force
    echo "source $(brew --prefix)/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh" | cat - ~/.zshrc | tee ~/.zshrc 
    source ~/.zshrc
}

setup_powerlevel10k_theme() {
    brew install powerlevel10k --force
    echo "source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" >> ~/.zshrc
}

setup_eclipse() {
    brew install --cask eclipse-jee --force
}

setup_intellij() {
    brew install --cask intellij-idea --force
}
setup_vscode() {
    brew install --cask visual-studio-code --force
    # Add code to PATH in present shell and also to .zprofile
    export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin" 
    cat << EOF >> ~/.zshrc
# Add Visual Studio Code (code) to PATH
export PATH=$PATH
EOF
}

setup_vscode_extensions() {
    code --install-extension vscjava.vscode-java-pack
    code --install-extension github.copilot
    code --install-extension github.copilot-chat
    code --install-extension github.copilot-labs
    code --install-extension vscjava.vscode-spring-initializr
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
    # Install latest
    sdk install java
    # Install Java 8.
    sdk install java 8.0.372-tem
}

setup_misc_utils() {
    # recursive tree listing command
    brew install tree --force
    # simplified man pages.
    brew install tldr --force
    # vim replacement
    brew install neovim --force
    echo "syntax on" >> ~/.vimrcbre
    # top like interface for container metrics
    brew install ctop --force
    brew install --cask postman --force
    brew install maven --force
    maven_version=`brew info maven --json | jq -r '.[].installed[].version'`
    cat << EOF >> ~/.zshrc
# Add Maven to Path
MAVEN_HOME=$(brew --prefix)/Cellar/maven/$maven_version/bin
export PATH=\$MAVEN_HOME/bin:\$PATH
EOF
    source ~/.zshrc
    

}

setup_mysql() {
    brew install mysql-client  --force
    cat << EOF >> ~/.zshrc
# Add MySql to PATH
export PATH=$(brew --prefix)/opt/mysql-client/bin:\$PATH
EOF
    source ~/.zshrc

    # Setup mysql workbench
    brew install --cask mysqlworkbench --force
}

setup_tomcat() {
    brew install tomcat@8
}
