# A .config folder for UNIX Systems

## Setup
```bash
git clone --recurse-submodules     git@github.com:chanwutk/config.git $HOME/.config
```
```bash
# OR
git clone --recurse-submodules https://github.com/chanwutk/config.git $HOME/.config
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
