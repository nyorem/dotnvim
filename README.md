# How to Install

```shell
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install neovim

python3 -m pip install --user --upgrade pynvim

sudo cp neovide.desktop /usr/local/share/applications
```

# Plugins

- coc.nvim
```
:CocInstall coc-clangd coc-pyright
```
- neogit
- telescope.nvim
- multiple cursors (TODO)

GUI: neovide
```
[Desktop Entry]
Name=neovide
Exec=/path/to/neovide.AppImage
Terminal=false
Type=Application
Icon=/path/to/neovide.png
```

# References

https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/
