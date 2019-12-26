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
```

```bash
chsh -s $(which fish)
fish
# logout and check
```

## [starship](https://starship.rs/zh-tw/)

```bash
brew install starship

curl -fsSL https://starship.rs/install.sh | sudo bash  # sudo?
```

```bash
# ~/.config/fish/config.fish

starship init fish | source
```

```bash
source ~/.config/fish/config.fish
```

## tmux

```
# ~/.tmux.conf

set-window-option -g prefix C-z
set-option -g mode-keys vi

set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'

set -g @plugin 'tmux-plugins/tmux-pain-control'

set -g @plugin 'tmux-plugins/tmux-yank'
set -g @plugin 'tmux-plugins/tmux-copycat'

set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'tmux-plugins/tmux-continuum'

run -b '~/.tmux/plugins/tpm/tpm'

tmux
```

# 2. git

```bash
git config --global user.name sljeff
git config --global user.email my@email.com

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
```

# 3. vim

## Newest vim

```bash
brew install vim

sudo add-apt-repository ppa:jonathonf/vim
sudo apt install vim
```

## [NeoBundle](https://github.com/Shougo/neobundle.vim)

```bash
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > install.sh
bash install.sh
```

## VIMRC

**[COPY .vimrc](./vimrc)**

```
vim
# press y and waiting for installation
```

# 4. python

## [pyenv-installer](https://github.com/pyenv/pyenv-installer)

```bash
curl https://pyenv.run | bash
```

```
# ~/.config/fish/config.fish

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
pyenv init - | source
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
select = B,C,E,F,W,T4,B9
exclude = .git,protos

vim a.py # check pyls, enable tabnine sem
```

# 5. [go](https://golang.org/doc/install)

```
tar -C /usr/local -xzf go?.?-?.tar.gz
mkdir ~/go

# ~/.config/fish/config.fish
export PATH="/usr/local/go/bin:$PATH"
export PATH="/$HOME/go/bin:$PATH"
export GOPATH="$HOME/go"
export GO111MODULE="on"
export GOPROXY="https://goproxy.cn/"
export GOPRIVATE="my.git.host"

go get golang.org/x/tools/gopls@latest
go get github.com/go-delve/delve/cmd/dlv
vim a.go # check gopls, enable tabnine sem
```

## [golangci-lint](https://github.com/golangci/golangci-lint#binary)

```
brew install golangci/tap/golangci-lint

# linux
bash
curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.21.0
```

## go-swagger [Binary](https://github.com/go-swagger/go-swagger/releases)

```
chmod +x swagger_?_?
sudo mv swagger_?_? /usr/local/bin/swagger
```

# 6. docker

## [macOS dmg](https://docs.docker.com/docker-for-mac/edge-release-notes/)

## [ubuntu installation](https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-docker-engine---community)

```bash
sudo apt-get purge docker-ce
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo rm -rf /var/lib/docker

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# 9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
```

## [post-install](https://docs.docker.com/install/linux/linux-postinstall/)

```bash
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
docker ps

# maybe
sudo chmod 666 /var/run/docker.sock
sudo chown root:docker /var/run/docker.sock
```

## run mysql/redis

```bash
docker run -d -p 6379:6379 redis:4
docker run -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=mypassword mysql:latest
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

https://github.com/wercker/stern/releases
```

## k9s [Binary](https://github.com/derailed/k9s/releases)

```
brew install derailed/k9s/k9s
```
