# neovim configuration

## Dependencies

Neovim:

```sh
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install neovim

python3 -m pip install --user --upgrade pynvim
```

git:
```sh
sudo apt install git gh
```

WSL:
```sh
sudo add-apt-repository ppa:wslutilities/wslu
sudo apt update
sudo apt install wslu
```

other stuff:
```sh
sudo apt install cmake shellcheck
```

## LSPs

- C/C++: [clangd](https://clangd.llvm.org/)
```sh
sudo apt install clangd
```

- Lua: [lua_ls](https://luals.github.io/#neovim-install)

- Python: [pyright](https://microsoft.github.io/pyright/)
```sh
pip install pyright --break-system-packages
```

## Formatters

- C/C++: [clang-format](https://clang.llvm.org/docs/ClangFormat.html)
```sh
sudo apt install clang-format
```

- Python: [ruff](https://docs.astral.sh/ruff/)
```sh
pip install ruff --break-system-packages
```

## Debuggers

- C/C++: [vscode-cpptools](https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(gdb-via--vscode-cpptools)) installed in `$HOME/dev/bin/cpptools-linux/`

- Python: [debugpy](https://github.com/microsoft/debugpy)
```sh
sudo apt install python3-debugpy
```

## References

You can checkout the [vim-plug](https://github.com/nyorem/dotnvim/tree/vim-plug) branch to see my old configuration before I switched to [lazy.nvim](https://github.com/folke/lazy.nvim).
