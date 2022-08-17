# setupEnv
My development enviroment set-up.

# 0. dependencies

```bash
xcode-select --install
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install git tmux
```

```bash
sudo apt update
sudo apt install wget build-essential git tmux
sudo apt install libssl-dev zlib1g-dev libncurses5-dev libncursesw5-dev libreadline-dev libsqlite3-dev
sudo apt install libgdbm-dev libdb5.3-dev libbz2-dev libexpat1-dev liblzma-dev libffi-dev uuid-dev 
```

# 1. shell

## [fish](https://github.com/fish-shell/fish-shell)


```bash
brew install fish

sudo apt-add-repository ppa:fish-shell/release-3
sudo apt-get update
sudo apt-get install fish

# ~/.config/fish/config.fish
export EDITOR="nvim"
```

```bash
chsh -s $(which fish)
fish
# logout and check
```

```
# fisher
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
fisher install evanlucas/fish-kubectl-completions jethrokuan/z laughedelic/pisces edc/bass
```

## [starship](https://starship.rs/zh-tw/)

```bash
brew install starship

curl -fsSL https://starship.rs/install.sh | sudo bash  # sudo?
```

```bash
# ~/.config/fish/config.fish
starship init fish | source

# ~/.config/starship.toml
# Don't print a new line at the start of the prompt
add_newline = true

[directory]
style = "bg:white bold fg:black"

# Replace the "❯" symbol in the prompt with "➜"
# [character]      # The name of the module we are configuring is "character"
# symbol = "➜"     # The "symbol" segment is being set to "➜"

# Disable the package module, hiding it from the prompt completely
[package]
disabled = true

[kubernetes]
disabled = false

# [memory_usage]
# disabled = false

[time]
disabled = false
style = "bold blue"

[python]
style = "bold blue"

[cmd_duration]
style = "bold blue"
```

```bash
source ~/.config/fish/config.fish
```

## tmux

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

```
# ~/.tmux.conf

set -g prefix C-z
set -g mode-keys vi
# set -g default-shell /usr/bin/fish
# set -g @themepack-status-right-area-middle-format "%H:%M"

set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'

set -g @plugin 'tmux-plugins/tmux-pain-control'

set -g @plugin 'tmux-plugins/tmux-yank'
set -g @plugin 'tmux-plugins/tmux-copycat'

set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'tmux-plugins/tmux-continuum'

# set -g @plugin 'jimeh/tmux-themepack'

set -g @plugin 'dracula/tmux'
set -g @dracula-plugins "battery network time"
set -g @dracula-show-left-icon session
set -g @dracula-show-timezone false
set -g @dracula-day-month false

run -b '~/.tmux/plugins/tpm/tpm'
```

```bash
tmux
# install plugins: prefix + I
```

# 2. git

```bash
git config --global user.name sljeff
git config --global user.email my@email.com
git config --global init.defaultBranch main

ssh-keygen
cat ~/.ssh/id_rsa.pub
# add to github and my git host
mkdir ~/proj
cd ~/proj
git clone git@github.com:sljeff/setupEnv.git
```

```
# ~/.gitconfig
[url "ssh://git@my.git.host/"]
        insteadOf = https://my.git.host/
[push]
        default = current
[core]
        editor = nvim
```

# 3. neovim

## Newest neovim

```bash
https://github.com/neovim/neovim/releases/
```

## [packer.nvim](https://github.com/wbthomason/packer.nvim#quickstart)

```bash
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```
```bash
# pip3 install --user pynvim
brew install ripgrep xplr
sudo apt-get install ripgrep
# xplr release https://github.com/sayanarijit/xplr/releases
```

## init.lua

**COPY [init.lua](./init.lua)** to your ~/.config/nvim/init.lua

open `nvim` and

```
:PackerInstall
:TSInstall go
:TSInstall python
```

Some information about keys in this vimrc:

- leader key is `SPACE`
- search `nnoremap` and check key mapping (exclude thus in `s:denite_my_settings` and `s:defx_my_settings`)
- `nnoremap` in `s:denite_my_settings` are for denite window
- `nnoremap` in `s:defx_my_settings` are for defx window (file explorer)

# 3.1 [nerd fonts](https://github.com/ryanoasis/nerd-fonts)

- [Download](https://github.com/ryanoasis/nerd-fonts#patched-fonts) one font you like.
- (BlexMono)
- Install on your OS
- use the font in terminal

# 4. python

## [pyenv-installer](https://github.com/pyenv/pyenv-installer)

```bash
curl https://pyenv.run | bash
```

```
# ~/.config/fish/config.fish

set -g PYENV_ROOT $HOME/.pyenv
fish_add_path $PYENV_ROOT/bin
pyenv init --path --no-rehash | source
```

```bash
pyenv install 3.8.1
pyenv global 3.8.1
pip install -U pip
pip install ipython flake8 flake8-bugbear mccabe pycodestyle pyflakes python-language-server

# ~/.config/pycodestyle
[pycodestyle]
ignore = E203, E266, E501, W503, B950
max-line-length = 90
max-complexity = 18
exclude = .git,protos

nvim a.py # check pyls, enable tabnine sem
```

# 5. [go](https://golang.org/doc/install)

```
tar -C /usr/local -xzf go?.?-?.tar.gz
mkdir ~/go

# ~/.config/fish/config.fish
fish_add_path /usr/local/go/bin
fish_add_path $HOME/go/bin
export GOPATH="$HOME/go"
export GO111MODULE="on"
export GOPROXY="https://goproxy.cn/"
export GOPRIVATE="my.git.host"

go install golang.org/x/tools/gopls@latest
go install github.com/go-delve/delve/cmd/dlv@latest
nvim a.go # check gopls
```

## [golangci-lint](https://github.com/golangci/golangci-lint#binary)

```
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
```

# 6. podman (docker)

## [installation](https://podman.io/getting-started/installation)

```bash
sudo apt-get -y install podman
pip3 install podman-compose
```

## post-install

```bash
alias docker=podman
alias docker-compose=podman-compose
```

## run mysql/redis

```bash
docker run -d -p 6379:6379 --name=redis redis:4
docker run -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=mypassword --name=mysql mysql:latest
# sudo nvim /etc/hosts
127.0.0.1 mysql
127.0.0.1 redis
```

# 7. [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

```
brew install kubernetes-cli

# ubuntu
sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl

kubectl version
```

```
# ~/.kube/config
```
## [stern](https://github.com/wercker/stern)

```
brew install stern

# https://github.com/wercker/stern/releases
```

## [kubectl-debug](https://github.com/aylei/kubectl-debug/blob/master/docs/zh-cn.md#%E5%AE%89%E8%A3%85-kubectl-debug-%E6%8F%92%E4%BB%B6)

```
brew install aylei/tap/kubectl-debug
```

## k9s [Binary](https://github.com/derailed/k9s/releases)

```
brew install derailed/k9s/k9s
```

## [ksd](https://github.com/mfuentesg/ksd)

```
go install github.com/mfuentesg/ksd@latest
```


# 8. nodejs

```
curl -fsSL https://fnm.vercel.app/install | bash
fnm completions --shell fish >> /home/jeff/.config/fish/conf.d/fnm.fish
fnm install v18
node --version
npm i -g typescript-language-server typescript
```
