# DEV TOOLS CONFIG

A collection of helper functions to help setup core tools on a Mac

## PreReqs
* Xcode installed.
  ```xcode-select --install```
  
## Usage
. ./dev_setup_utils.sh

This will give access to the below functions. For Brew installs, script will check if version already installed, then upgrade if necessary and to the path if required.

| Function | Description |
|----------|-------------|
| setup_brew() | `homebrew` and xcode command line tools (via GUI) if required. Should be the first thing you run as other functions may have dependencies on homebrew for installation.|
| setup_terminal() | `iterm2`, `oh-my-zsh`. You should run setup_powerlevel_10k_theme() to setup powerlevel10 theme. Can't be done in the same function (easily) as this script changes the shell and requires a restart of the shell |
| setup_powerlevel10k_theme() | `powerlevel10k` theme. Once installed, and zsh shell is launched for the first time, then wizard will guide through configuration. Alternatively you can run `p10k configure` at any time to run through the shell setup again. THis will also append to your `~/.zshrc` file.|
| setup_ides() | Will call `setup_eclipse()`, `setup_intellij()`, `setup_vscode()` to setup those respective IDEs.|
| setup_eclipse() | `eclipse-jee` via brew/cask |
| setup_intellij() | `Intellij Ultimate` via brew/cask |
| setup_vscode() | `Visual Studio Code` and extensions |
| setup_python() | `python 3` and `pip`
| setup_misc_utils() | `tldr` (Simplified man pages), `tree` (recursive tree like dir listing), `neovim` (vim replacement), `ctop` (top for containers), `jq` (json command line parsing) |
| setup_node() |  `nvm`,`node` | 
| setup_dev_tools() | `maven`, `postman`, `jmeter`
| setup_config_defaults() | `show hidden files in finder`. Will continue to add to this function. |
| setup_sdkman() | `sdkman`, pupular SDK manager for Java and other SDKs. |
| setup_java8() | `jdk8` |


## Other useful dev setup guides
https://medium.com/@bschlining/my-macos-development-environment-of-2018-acf9c7537a58

## TODO
1. gcloud setup
2. Docker setup
3. VS Code plugin setup
4. eclipse.ini JVM configuration.

