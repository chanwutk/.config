# A .config folder for Linux / MacOS

## Setup
```bash
git clone --recurse-submodules --depth 1     git@github.com:chanwutk/config.git $HOME/.config
```
```bash
# OR
git clone --recurse-submodules --depth 1 https://github.com/chanwutk/config.git $HOME/.config
```

### Setup rc and profile
```bash
# In .bashrc or .zshrc
# NOTE: after conda setup (if available)
source $HOME/.config/rc

# In .profile, .bash_profile, or .zprofile
# NOTE: before sourcing rc
source $HOME/.config/profile
```
