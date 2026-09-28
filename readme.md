first commit readme


```bash 
[ -d ~/.config/aerospace ] && mv --backup=numbered ~/.config/aerospace ~/.config/aerospace

git clone https://github.com/PoutineSyropErable/config_aerospace ~/.config/aerospace

[ -f ~/.aerospace.toml ] && mv --backup=numbered ~/.aerospace.toml ~/.aerospace.toml.bak

ln -s ~/.config/aerospace/.aerospace.toml ~/.aerospace.toml


```
