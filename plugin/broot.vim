let s:broot_command = 'broot'
let s:out_file_path = tempname()

function! OpenBrootIn(path, edit_cmd)
  let currentPath = expand(a:path) ? expand(a:path) : expand(".")
  let brootCallback = { 'name': 'broot', 'edit_cmd': a:edit_cmd }
  function! brootCallback.on_exit(job_id, code, event)
    if a:code == 0
      silent! Bclose!
    endif
    try
      if filereadable(s:out_file_path)
        for f in readfile(s:out_file_path)
          exec self.edit_cmd . f
        endfor
        call delete(s:out_file_path)
      endif
    endtry
  endfunction
  enew
  echom currentPath
  call termopen(s:broot_command . ' --out=' . s:out_file_path . ' "' . currentPath . '"', brootCallback)
  startinsert
endfunction

let s:default_edit_cmd='edit '

command! BrootCurrentFile call OpenBrootIn("%", s:default_edit_cmd)
command! BrootCurrentDirectory call OpenBrootIn("%:p:h", s:default_edit_cmd)
command! BrootWorkingDirectory call OpenBrootIn(".", s:default_edit_cmd)
command! Broot BrootCurrentFile

" For retro-compatibility
function! OpenBroot()
  Broot
endfunction

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
