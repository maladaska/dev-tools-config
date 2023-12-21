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

brew_install() {
    if brew list $1 2>&1 > /dev/null; then 
        echo "$1 is alread installed. Checking for upgrades."
        installed_version=$(brew info --json $1 | jq -r '(.[] | [ (.installed[] | .version) ]) | @tsv')
        latest_version=$(brew info --json $1 | jq -r '(.[] | [  .versions.stable ]) | @tsv')

        if [[ "$installed_version" != "$latest_version" ]]; then
            echo "Upgrade available from $installed_version to $latest_version. Upgrading..."
            brew update && brew upgrade $1 && brew cleanup $1
            # TODO - remove existing entry from path
            add_to_path_zsh $1
        else 
            echo "Latest version for $1 already installed ($installed_version)"
        fi
    else
        echo "Installing $1"
        brew install $1 && echo "$1 is installed"
        add_to_path_zsh $1
    fi
}

add_to_path_zsh() {
    # TODO: Tidy up to remove existing entries from PATH
    bin_dir=`brew list $1 | grep "/bin" | head -1 | xargs dirname`

    if [[ ! -z "$bin_dir"  ]]; then 
        install_time=`date '+%Y-%m-%d %H:%M%:%S'`
        cat << EOF >> ~/.zshrc
# $0 added $1 to path at $install_time
export PATH=$bin_dir:\$PATH
EOF
        source ~/.zshrc
        echo "Added $bin_dir to PATH and rehased .zshrc"
        cat ~/.zshrc | tail -1
    fi
}

setup_python() {
    brew_install python3
    python3 -m pip install --upgrade pip
}

setup_node() {
    brew_install nvm
    brew_install node
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
    
    brew_install zsh-autocomplete
    echo "source $(brew --prefix)/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh" | cat - ~/.zshrc | tee ~/.zshrc 
    source ~/.zshrc
}

setup_powerlevel10k_theme() {
    brew_install powerlevel10k
    echo "source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" >> ~/.zshrc
}

setup_eclipse() {
    brew install --cask eclipse-jee --force
}

setup_intellij() {
    brew install --cask intellij-idea --force
}
setup_vscode_extensions() {
    code --install-extension vscjava.vscode-java-pack
    code --install-extension github.copilot
    code --install-extension github.copilot-chat
    code --install-extension github.copilot-labs
    code --install-extension vscjava.vscode-spring-initializr
}
setup_vscode() {
    brew install --cask visual-studio-code --force
    # Add code to PATH in present shell and also to .zprofile
    export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin" 
    cat << EOF >> ~/.zshrc
# Add Visual Studio Code (code) to PATH
export PATH=$PATH
EOF
    source ~/.zshrc
    setup_vscode_extensions
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
    brew_install tree
    # command line json parsing
    brew_install jq
    # simplified man pages.
    brew_install tldr
    # vim replacement
    brew_install neovim
    echo "syntax on" >> ~/.vimrcbre
    # top like interface for container metrics
    brew_install ctop
}

setup_mysql() {
    brew_install mysql-client
    # Setup mysql workbench
    brew install --cask mysqlworkbench --force
}

setup_tomcat() {
    brew_install tomcat@8
}

setup_browsers() {
    brew install --cask firefox --force
    brew install --cask google-chrome --force
}

setup_dev_tools() {
    brew install --cask postman --force
    brew_install maven
    brew_install jmeter
}