# How to Install

```shell
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install neovim

python3 -m pip install --user --upgrade pynvim
```

## Plugins setup

- coc.nvim
```
:CocInstall coc-clangd coc-pyright
```

# Miscelleneous

Create desktop entry for neovide:
```
[Desktop Entry]
Name=neovide
Exec=/path/to/neovide
Terminal=false
Type=Application
Icon=/path/to/neovide.png
```

and then
```shell
sudo cp neovide.desktop /usr/share/applications
```

# References

- https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/
- https://dev.to/vonheikemen/neovim-using-vim-plug-in-lua-3oom

TODO
