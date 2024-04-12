#!/bin/sh

# Taking input first to finish the setup
printf " Do you want to install the PKGs? "
read PKG_INPUT

printf " Do you want to install and Set up Virt-manager? "
read VIRT_INPUT 

printf " Do you want to install and Set up dotfiles git bare repo? "
read DOTFILES_INPUT

printf " Do you want to install and Set up Zsh? "
read ZSH_INPUT 

# PKGs download and setup
if [ $PKG_INPUT = "y" ]
  then
   printf " Downloading PKGs\n"
sudo apt install rofi awesome kitty neovim materia-gtk-theme \
lxappearance nitrogen volumeicon-alsa network-manager-gnome  \
redshift flameshot parcellite xfce4-notifyd     \
xfce4-power-manager pavucontrol cmatrix htop speedtest-cli   \
zsh-syntax-highlighting autojump zsh-autosuggestions         \
papirus-icon-theme playerctl ibus fonts-jetbrains-mono       \
qbittorrent timeshift -y

else
   printf " Canceled The PKGs installation\n"
fi

# virt-manager for QEMU management
if [ $VIRT_INPUT = "y" ]
  then
printf "\n\t  #### Downloading and Setting up Virt-manager  ####\n\n"
sudo apt install qemu virt-manager ebtables dnsmasq -y
sudo systemctl start libvirtd.service virtlogd.service
sudo systemctl enable libvirtd.service
sudo usermod -G libvirt -a $USER 
else
   printf " Canceled install and setup for Virt-manager"
fi


### My dotfiles git bare repo
if [ $DOTFILES_INPUT = "y" ]
  then
   printf " Cloning and Setting up dotfiles in the home dir\n"
git clone https://github.com/Ahmed-Al-Balochi/dotfiles.git ~/Downloads/dotfiles.git
cp -rf ~/Downloads/dotfiles.git/.* ~/
printf "Cloning Git bare repo"
git clone --bare https://github.com/Ahmed-Al-Balochi/dotfiles.git ~/bareDotfiles
cd ~/bareDotfiles
printf "Setting up Git bare repo"
config config --local status.showUntrackedFiles no
config add .bashrc .zshrc .config/awesome .config/alacritty \ 
.config/bspwm .config/kitty .config/nitrogen .config/picom  \ 
.config/picom .config/polybar .config/qtile .config/rofi    \
.config/sxhkd .local/bin/Arch-Mypkgs.sh                     \
.local/bin/Fedora-Mypkgs.sh .local/bin/Ubuntu-Mypkgs.sh     \
.local/bin/BSPWM-install.sh .local/bin/BSPWM-package-list.txt \
.local/bin/IosevkaTermNerdFontComplete.ttf .config/obs-studio \
README.md LICENSE

else
   printf " Canceled the git bare repo\n"
fi

### Zsh
if [ $ZSH_INPUT  = "y" ]
  then
   printf " Setting Zsh\n"
touch "$HOME/.cache/zshhistory"
#-- Setup Alias in $HOME/zsh/aliasrc
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc

#Finish the conversion by changing your user in /etc/passwd to /bin/zsh instead of /bin/bash
#or typing chsh $USER and entering /bin/zsh
chsh
echo "You should Reboot Now"

else
   printf " Canceled Setting up Zsh\n"
fi
