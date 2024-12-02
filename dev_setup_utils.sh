#!/bin/sh

setup_brew() {
    echo "...installing homebrew (and xcode command line tools if required)"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Add to path now so that other functions from this script will work. Note, on intel based macs this is different.
    HOMEBREW_PREFIX=/opt/homebrew
    export PATH=$HOMEBREW_PREFIX/bin:$PATH 
    cat << EOF >> ~/.zshrc
# Add homebrew  to Path
export PATH=$HOMEBREW_PREFIX/bin:\$PATH
EOF
}

setup_prereqs() {
    xcode-select --install
    softwareupdate --install-rosetta
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
            #add_to_path_zsh $1
        else 
            echo "Latest version for $1 already installed ($installed_version)"
        fi
    else
        echo "Installing $1"
        brew install $1 && echo "$1 is installed"
        #add_to_path_zsh $1
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
    defaults write -g com.apple.swipescrolldirection -bool NO
    defaults write -g com.apple.trackpad.enable-natural-scrolling -bool NO
    killall Finder
    killall Dock
    killall -u $USER cfprefsd

cat << EOF >> ~/.vimrc
syntax on
set number
set showmatch
set tabstop=4
set shiftwidth=4
set expandtab
set wrap
set ruler
set mouse=a
set encoding=utf-8
EOF
}

setup_terminal() {
    echo "...installing iterm2."
    brew install --cask iterm2 --force
    echo "...installing oh my zsh."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
   
#    brew_install zsh-autocomplete
#    echo "source $(brew --prefix)/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh" | cat - ~/.zshrc | tee ~/.zshrc 
#    source ~/.zshrc
}


setup_eclipse() {
    brew install --cask eclipse-jee --force
}

setup_intellij() {
    brew install --cask intellij-idea --force
}
setup_vscode_extensions() {
    code --install-extension vscjava.vscode-java-pack --force
    code --install-extension github.copilot --force
    code --install-extension github.copilot-chat --force
    code --install-extension vscjava.vscode-spring-initializr --force
    code --install-extension ms-kubernetes-tools.vscode-kubernetes-tools --force
    code --install-extension ms-azuretools.vscode-docker --force
}
setup_vscode() {
    brew install --cask visual-studio-code --force
    # Add code to PATH in present shell and also to .zprofile
    export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH" 
    cat << EOF >> ~/.zshrc
# Add Visual Studio Code (code) to PATH
export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:\$PATH"
EOF
    source ~/.zshrc
    setup_vscode_extensions
}
setup_docker() {
    brew install --cask docker
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
    # Install latest
    sdk install java
}

setup_misc_utils() {
    # recursive tree listing command
    brew_install tree
    # command line json parsing
    brew_install jq
    # simplified man pages.
    brew_install tldr
    # top like interface for container metrics
    brew_install ctop
    brew_install wget
    brew_install htop
}

setup_mysql() {
    brew_install mysql-client
    # Setup mysql workbench
    brew install --cask mysqlworkbench --force
}

setup_tomcat() {
    brew_install tomcat@9
}

setup_browsers() {
    brew install --cask firefox --force
    brew install --cask google-chrome --force
}

setup_dev_tools() {
    setup_java
    setup_node
    setup_ides
    brew install --cask postman --force
    brew_install maven
    brew_install jmeter
    setup_tomcat
    setup_mysql
    setup_docker
    setup_python
}

first_time_setup() {
    setup_prereqs
    setup_brew
    setup_sdkman
    setup_terminal
    setup_misc_utils
    setup_browsers
    setup_dev_tools
    setup_config_defaults
}
