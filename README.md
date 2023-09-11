# DEV TOOLS CONFIG

A collection of helper functions to help setup core tools on a Mac

## Usage
. ./dev_setup_utils.sh

This will give access to the following functions:

| Function | Description |
|----------|-------------|
| setup_brew() | Install homebrew and xcode command  line tools (via GUI) if required. Should be the first thing you run as other functions may have dependencies on homebrew for installation.|
| setup_terminal() | Installs iterm2, oh-my-zsh. You should run setup_powerlevel_10k_theme() to setup powerlevel10 theme. Can't be done in the same function (easily) as this script changes the shell and requires a restart of the shell |
| setup_powerlevel10k_theme() | Downloads and installs the powerlevel10k theme. Once installed, and zsh shell is launched for the first time, then wizard will guide through configuration. Alternatively you can run `p10k configure` at any time to run through the shell setup again. THis will also append to your `~/.zshrc` file.|
| setup_ides() | Will call `setup_eclipse()`, `setup_intellij()`, `setup_vscode()` to setup those respective IDEs. Alternatively you can call each function individually. |
| setup_eclipse() | Download and install eclipse-jee via brew/cask |
| setup_intellij() | Download and install intellij ultimate via brew/cask |
| setup_vscode() | Download and install VS Code via brew/cask |
| setup_python() | Install python 3 and pip
| setup_misc_utils() | `tldr` (Simplified man pages), `tree` (recursive tree like dir listing), `neovim` (vim replacement), `ctop` (top for containers) |
| setup_node() | setup nvm and node | 
| setup_config_defaults() | Useful helper function to set core defaults, e.g. show hidden files in finder. Will continue to add to this function.



## Other useful dev setup guides
https://medium.com/@bschlining/my-macos-development-environment-of-2018-acf9c7537a58

## TODO
1. gcloud setup
2. Docker setup
3. VS Code plugin setup
4. eclipse.ini JVM configuration.
5. JAVA / JDK setup.

