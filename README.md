# Neovim Path Helpers

This plugin is based entirely on the idea from [this gist](https://gist.github.com/romainl/c8266473ae77b637eda8913c365db6dc)

## Quickstart

```vim
Plug 'cidem/neovim-set-path'
```

Add this to your `init.vim`

```vim
augroup SetPath
		autocmd!
		autocmd BufEnter,DirChanged * call pathutils#SetPath()
augroup END
command! -nargs=0 UpdatePath :call pathutils#SetPath()
```

Your buffer-local `path` will now be updated based on the above events and also whenever you manually call `:UpdatePath`.
