#!/usr/bin/env bash

# Install zsh and set as default.
sudo apt-get install -y zsh
sudo chsh -s /bin/zsh $USER

# Install and configure Oh My ZSH (if it is not already installed).
if [ -d "$HOME/.oh-my-zsh" ] 
then
    echo "oh-my-zsh is already installed" 
else
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    # Append zshrc stuff to end of file
    touch ~/.zshrc # not sure if this will always exist at this point :/
    cat .zshrc >> ~/.zshrc
fi

DOTFILES_CLONE_PATH=$HOME/dotfiles
for dotfile in "$DOTFILES_CLONE_PATH/".*; do
  # Skip `..` and '.'
  [[ $dotfile =~ \.{1,2}$ ]] && continue
  # Skip Git related
  [[ $dotfile =~ \.git$ ]] && continue
  [[ $dotfile =~ \.gitignore$ ]] && continue
  [[ $dotfile =~ \.gitattributes$ ]] && continue

  echo "Symlinking $dotfile"
  ln -sf "$dotfile" "$HOME"
done

# Install tmux plugin manager.
if [ -d "$HOME/.tmux/plugins/tpm" ] 
then
    echo "tpm is already installed"
else
    sudo apt-get install -y xsel
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
