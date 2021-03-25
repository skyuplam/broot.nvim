# broot.nvim lightweight broot integration plugin for nvim

This is a lightweight integration plugin for [Broot](https://github.com/Canop/broot) and [neovim](https://neovim.io/).

Sorry vim, you can use the plugin from [broot.vim](https://gitlab.com/lstwn/broot.vim/-/tree/master)

[![asciicast](https://asciinema.org/a/402488.svg)](https://asciinema.org/a/402488)

## Installation

Use your favorite plugin manager or use packer.nvim

```
use 'skyuplam/broot.nvim'
```

Put this into your Broot config, e.g. `$XDG_CONFIG_HOME/broot/conf.hjson`

```
verbs: [
  {
    invocation: terminal
    # use any keybinding your want to print the path
    # such that nvim can read it via the plugin, e.g. "ctrl-o" or "entry"
    key: ctrl-o
    execution: ":print_path"
    apply_to: file
  }
]
```

When the plugin is installed, use `:Broot` to launch Broot.

## Inspired from

- [ranger.vim](https://github.com/francoiscabrol/ranger.vim)
- [broot.vim](https://gitlab.com/lstwn/broot.vim/-/tree/master)
