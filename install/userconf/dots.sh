# symlink dotfiles via stow and rebuild font cache

# stow dotfiles
cd "$REAL_HOME/.dotfiles"
sudo -u "$REAL_USER" stow --adopt -v */
sudo -u "$REAL_USER" git -C "$REAL_HOME/.dotfiles" restore . || true

# rebuild font cache
sudo -u "$REAL_USER" fc-cache -fv
