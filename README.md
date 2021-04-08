# broot.nvim lightweight broot integration plugin for nvim

This is a lightweight integration plugin for [Broot](https://github.com/Canop/broot)
and [neovim](https://neovim.io/) as a replacement of the [NerdTree plugin](https://github.com/preservim/nerdtree)

Sorry vim, you can use the plugin from [broot.vim](https://gitlab.com/lstwn/broot.vim/-/tree/master)

[![asciicast](https://asciinema.org/a/402488.svg)](https://asciinema.org/a/402488)

## Installation

Use your favorite plugin manager, e.g. [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use 'skyuplam/broot.nvim'
use 'rbgrouleff/bclose.vim'
```

You need [bclose.vim](https://github.com/rbgrouleff/bclose.vim) to close the
opened buffer

Put this beside your Broot config, e.g. `$XDG_CONFIG_HOME/broot/nvim.hjson` to
override the default `enter` key-binding to allow open with the running nvim
client

```hjson
# $XDG_CONFIG_HOME/broot/nvim.hjson
{
  verbs: [
    {
      invocation: terminal
      key: enter
      execution: ":print_path"
      apply_to: file
    }
  ]
}
```

When the plugin is installed, use `:Broot` to launch Broot, and use the key-binding
to edit the file.

## Inspired from

- [ranger.vim](https://github.com/francoiscabrol/ranger.vim)
- [broot.vim](https://gitlab.com/lstwn/broot.vim/-/tree/master)
