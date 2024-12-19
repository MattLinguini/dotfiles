# Dotfiles

## Requirements
```
sudo pacman -Syu git stow
```

## How to Install
```bash
cd # Make sure you are in the home directory
git clone https://github.com/MattLinguini/dotfiles.git # Clone repo into 'dotfiles' folder
cd dotfiles # Go into the dotfiles directory
stow . # Create Syslinks for all the files
```