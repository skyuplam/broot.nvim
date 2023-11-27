let s:broot_command = 'broot'
let s:out_file_path = tempname()
let s:broot_default_config_path = fnamemodify(expand('$XDG_CONFIG_HOME/broot/conf.hjson'), ':p')
let s:broot_nvim_config_path = fnamemodify(s:broot_default_config_path, ':h') . '/nvim.hjson'
let s:broot_config_path = s:broot_default_config_path . ';' . s:broot_nvim_config_path

function! s:brootCallback(code, cmd) abort
  if a:code == 0
    silent! Bclose!
  endif
  try
    if filereadable(s:out_file_path)
      for f in readfile(s:out_file_path)
        exec a:cmd . f
      endfor
      call delete(s:out_file_path)
    endif
  endtry
endfunction

function! OpenBrootIn(path, edit_cmd)
  let currentPath = len(expand(a:path)) != 0 ? expand(a:path) : expand(".")
  let cmd = printf(
        \ '%s --conf "%s" --outcmd "%s" "%s"',
        \ s:broot_command,
        \ s:broot_config_path,
        \ s:out_file_path,
        \ currentPath
        \ )
  enew
  call termopen(cmd, {
        \ 'name': 'broot',
        \ 'on_exit': {status, code -> s:brootCallback(code, a:edit_cmd)},
        \ })
  startinsert
endfunction

let s:default_edit_cmd='edit '

command! BrootCurrentFile call OpenBrootIn("%", s:default_edit_cmd)
command! BrootCurrentDirectory call OpenBrootIn("%:p:h", s:default_edit_cmd)
command! BrootWorkingDirectory call OpenBrootIn(".", s:default_edit_cmd)
command! Broot BrootCurrentFile

" Open Broot in the directory passed by argument
function! OpenBrootOnVimLoadDir(argv_path)
  let path = expand(a:argv_path)

  " Delete empty buffer created by vim
  Bclose!

  " Open Broot
  call OpenBrootIn(path, 'edit')
endfunction

" To open broot when vim load a directory
if exists('g:broot_replace_netrw') && g:broot_replace_netrw
  augroup ReplaceNetrwByBrootVim
    autocmd VimEnter * silent! autocmd! FileExplorer
    autocmd BufEnter * if isdirectory(expand("%")) | call OpenBrootOnVimLoadDir("%") | endif
  augroup END
endif
