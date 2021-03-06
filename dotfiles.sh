#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/.dotfiles                         # dotfiles directory
olddir=~/.dotfiles_old                  # old dotfiles backup directory
privateDir=~/.dotfilesPrivate           # private dotfiles
oldPrivateDir=~/.dotfilesPrivate_old    # old private dotfiles
#files="bashrc vimrc vim zshrc oh-my-zsh"    # list of files/folders to symlink in homedir
files="zshrc aliases bashrc bash_profile profile vim vimrc tmux.conf"    # list of files/folders to symlink in homedir
##########

# create dotfiles_old in homedir
printf "\n${GREEN}Creating $olddir for backup of any existing dotfiles in ~\n"
mkdir -p $olddir
printf "${GREEN}...done\n"

# change to the dotfiles directory
printf "\n${GREEN}Changing to the $dir directory\n"
cd $dir
printf "${GREEN}...done\n"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    printf "\n${GREEN}Moving ~/.$file to $olddir/.$file\n"
    mv ~/.$file $olddir/
    printf "${GREEN}Creating symlink to $file in home directory.\n"
    ln -s $dir/$file ~/.$file
done
