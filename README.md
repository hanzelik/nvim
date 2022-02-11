# nvim

My personal nvim configuration

## Notes
I moved away from [coc.nvim](https://github.com/neoclide/coc.nvim) and started to use the native LSP baked into neovim. The main reason I've done this is for simplicity, and the fact I want to use as much native
things to neovim as possible.


I also found an awesome blog post about [setting up neovim to work with the native LSP and rust](https://sharksforarms.dev/posts/neovim-rust/).


Generally speaking, I want to keep my configuration minimal and not too flashy. Maybe I'll add eye candy in
the future, If I feel like it.

## How to Install

```
git clone https://github.com/hanzelik/nvim.git
```

Once that is done, head over to [vim-plug](https://github.com/junegunn/vim-plug) to install used plugins.


Ignore and errors associated with colorscheme, those will be fixed with `:PlugInstall`


Once inside nvim, run the command `:PlugInstall`
