FROM archlinux/base

# Install packages
ADD mirrorlist /etc/pacman.d/mirrorlist
RUN curl https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage -LO && chmod +x ./nvim.appimage && ./nvim.appimage --appimage-extract && rm ./nvim.appimage && mv squashfs-root /usr/local/bin/ && ln -s /usr/local/bin/squashfs-root/usr/bin/nvim /usr/local/bin/nvim
RUN pacman -Syyu --noconfirm
RUN pacman -S --noconfirm diffutils procps-ng openssh man-db gawk
RUN pacman -S --noconfirm gcc make cmake boost
RUN pacman -S --noconfirm zsh tmux curl less docker-compose git ripgrep
RUN pacman -S --noconfirm php composer
RUN pacman -S --noconfirm python python-pip python2 python2-pip
RUN pacman -S --noconfirm nodejs npm
RUN pacman -S --noconfirm ruby
RUN pacman -S --noconfirm perl
RUN pacman -S --noconfirm go

# Language Settings
RUN composer global require hirak/prestissimo
RUN pip3 install --upgrade pip pynvim python-language-server[all]
RUN pip2 install --upgrade pip pynvim
RUN npm install -g npm neovim javascript-typescript-langserver typescript-language-server intelephense vscode-html-languageserver-bin vscode-css-languageserver-bin vim-language-server
RUN gem install -N --no-user-install neovim
RUN go get -u golang.org/x/tools/gopls

# Environment Settings
RUN git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
RUN git clone https://github.com/Shougo/dein.vim ~/.config/nvim/dein/repos/github.com/Shougo/dein.vim
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

