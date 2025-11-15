# Manually do this the first time
#sudo echo "max_parallel_downloads=10" >> /etc/dnf/dnf.conf
#sudo echo "fastestmirror=True" >> /etc/dnf/dnf.conf
#sudo echo "defaultyes=True" >> /etc/dnf/dnf.conf

set -xe


#general
sudo dnf install neovim btop clang clang-tools-extra cmake ripgrep fd-find fzf nodejs-npm zsh golang

#shell
sudo dnf install zsh
sudo chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#oh-my-posh
mkdir $HOME/.local/bin
curl -s https://ohmyposh.dev/install.sh | bash -s -- -d $HOME/.local/bin

#Plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

#Brave
curl -fsS https://dl.brave.com/install.sh | sh

#kitty
mkdir $HOME/.config/kitty
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
mv $HOME/.config/nvim/temp/kitty/applicaitons/kitty.conf $HOME/.config/kitty/kitty.conf
mv $HOME/.config/nvim/temp/kitty/applicaitons/font-nerd-symbols.conf $HOME/.config/kitty/font-nerd-symbols.conf

#Sioyek
sudo dnf install qt5-qtbase-devel qt5-qtbase-static qt5-qt3d-devel harfbuzz-devel mesa-libGL-devel glfw-devel
git clone --recursive https://github.com/ahrm/sioyek $HOME/Downloads/sioyek
cd $HOME/Downloads/sioyek
./build_linux.sh
sudo mv build/** /usr/local/bin/
cd
rm -rf $HOME/Downloads/sioyek
mv $HOME/.config/nvim/temp/sioyek/keys_user.config  $HOME/.config/sioyek/keys_user.config
mv $HOME/.config/nvim/temp/sioyek/prefs_user.config $HOME/.config/sioyek/prefs_user.config

#Zig
cd $HOME/Downloads
mkdir -p zig
cd zig
curl -L https://ziglang.org/download/0.14.0/zig-linux-aarch64-0.14.0.tar.xz > zig.tar.gz
tar -xvf zig.tar.gz
mv zig-linux-aarch64-0.14.0 zig

#nvim config
git clone https://github.com/rohit-kumar-j/nvim.git $HOME/.config/nvim
mv $HOME/.config/nvim/temp/.zshrc $HOME/.zshrc

#Cargo
curl https://sh.rustup.rs -sSf | sh

#lazygit
sudo dnf copr enable atim/lazygit -y
sudo dnf install lazygit -y


sudo dnf update -y
