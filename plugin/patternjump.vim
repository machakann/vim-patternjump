" Vim global plugin for moving cursor by assigned patterns
" Last Change: 17-Feb-2014.
" Maintainer : Masaaki Nakamura <mckn@outlook.com>

" License    : NYSL
"              Japanese <http://www.kmonos.net/nysl/>
"              English (Unofficial) <http://www.kmonos.net/nysl/index.en.html>

if exists("g:loaded_patternjump")
  finish
endif
let g:loaded_patternjump = 1

""" commands
command! -nargs=0 PatternjumpDebugModeOn     call s:debug_mode_on()
command! -nargs=0 PatternjumpDebugModeOff    call s:debug_mode_off()
command! -nargs=0 PatternjumpDebugModeToggle call s:debug_mode_toggle()
command! -nargs=0 PatternjumpCachingOn       call s:caching_on()
command! -nargs=0 PatternjumpCachingOff      call s:caching_off()
command! -nargs=0 PatternjumpCachingToggle   call s:caching_toggle()
command! -nargs=0 PatternjumpCachingDelete   unlet! b:patternjump_forward_cache | unlet! b:patternjump_backward_cache

function! s:debug_mode_on()
  if exists('b:patternjump_debug_mode')
    let b:patternjump_debug_mode = 1
    return
  endif

  if exists('w:patternjump_debug_mode')
    let w:patternjump_debug_mode = 1
    return
  endif

  if exists('t:patternjump_debug_mode')
    let t:patternjump_debug_mode = 1
    return
  endif

  let g:patternjump_debug_mode = 1
endfunction

function! s:debug_mode_off()
  if exists('g:patternjump_debug_mode')
    let g:patternjump_debug_mode = 0
  endif

  if exists('t:patternjump_debug_mode')
    let t:patternjump_debug_mode = 0
  endif

  if exists('w:patternjump_debug_mode')
    let w:patternjump_debug_mode = 0
  endif

  if exists('b:patternjump_debug_mode')
    let b:patternjump_debug_mode = 0
  endif
endfunction

function! s:debug_mode_toggle()
  if exists('b:patternjump_debug_mode')
    let b:patternjump_debug_mode = !b:patternjump_debug_mode
    return
  endif

  if exists('w:patternjump_debug_mode')
    let w:patternjump_debug_mode = !w:patternjump_debug_mode
    return
  endif

  if exists('t:patternjump_debug_mode')
    let t:patternjump_debug_mode = !t:patternjump_debug_mode
    return
  endif

  if exists('g:patternjump_debug_mode')
    let g:patternjump_debug_mode = !g:patternjump_debug_mode
    return
  endif

  let g:patternjump_debug_mode = 1
endfunction

function! s:caching_on()
  if exists('b:patternjump_caching')
    let b:patternjump_caching = 1
    return
  endif

  if exists('w:patternjump_caching')
    let w:patternjump_caching = 1
    return
  endif

  if exists('t:patternjump_caching')
    let t:patternjump_caching = 1
    return
  endif

  let g:patternjump_caching = 1
endfunction

function! s:caching_off()
  if exists('g:patternjump_caching')
    let g:patternjump_caching = 0
  endif

  if exists('t:patternjump_caching')
    let t:patternjump_caching = 0
  endif

  if exists('w:patternjump_caching')
    let w:patternjump_caching = 0
  endif

  if exists('b:patternjump_caching')
    let b:patternjump_caching = 0
  endif

  unlet! b:patternjump_forward_cache
  unlet! b:patternjump_backward_cache
endfunction

function! s:caching_toggle()
  if exists('b:patternjump_caching')
    if b:patternjump_caching
      let b:patternjump_caching = 0
      unlet! b:patternjump_forward_cache
      unlet! b:patternjump_backward_cache
    else
      let b:patternjump_caching = 1
    endif

    return
  endif

  if exists('w:patternjump_caching')
    if w:patternjump_caching
      let w:patternjump_caching = 0
      unlet! b:patternjump_forward_cache
      unlet! b:patternjump_backward_cache
    else
      let b:patternjump_caching = 1
    endif

    return
  endif

  if exists('t:patternjump_caching')
    if t:patternjump_caching
      let t:patternjump_caching = 0
      unlet! b:patternjump_forward_cache
      unlet! b:patternjump_backward_cache
    else
      let b:patternjump_caching = 1
    endif

    return
  endif

  if exists('g:patternjump_caching')
    if g:patternjump_caching
      let g:patternjump_caching = 0
      unlet! b:patternjump_forward_cache
      unlet! b:patternjump_backward_cache
    else
      let g:patternjump_caching = 1
    endif

    return
  endif

  let g:patternjump_caching = 1
endfunction

""" keymappings
" forward
nnoremap <silent> <Plug>(patternjump-forward)  :<C-u>call patternjump#forward('n')<CR>
xnoremap <silent> <Plug>(patternjump-forward)  :<C-u>call patternjump#forward('x')<CR>
onoremap <silent> <Plug>(patternjump-forward)  :<C-u>call patternjump#forward('o')<CR>
inoremap <silent> <Plug>(patternjump-forward)  <C-r>=patternjump#forward('i')<CR>
cnoremap          <Plug>(patternjump-forward)  <C-r>=patternjump#forward('c')<CR>
" backward
nnoremap <silent> <Plug>(patternjump-backward) :<C-u>call patternjump#backward('n')<CR>
xnoremap <silent> <Plug>(patternjump-backward) :<C-u>call patternjump#backward('x')<CR>
onoremap <silent> <Plug>(patternjump-backward) :<C-u>call patternjump#backward('o')<CR>
inoremap <silent> <Plug>(patternjump-backward) <C-r>=patternjump#backward('i')<CR>
cnoremap          <Plug>(patternjump-backward) <C-r>=patternjump#backward('c')<CR>

""" default keymappings
" If g:verticalmove_no_default_key_mappings has been defined, then quit
" immediately.
if exists('g:patternjump_no_default_key_mappings') | finish | endif

" forward
if !hasmapto('<Plug>(patternjump-forward)')
  silent! nmap <unique> <M-l> <Plug>(patternjump-forward)
  silent! xmap <unique> <M-l> <Plug>(patternjump-forward)
  silent! omap <unique> <M-l> <Plug>(patternjump-forward)
  silent! imap <unique> <M-l> <Plug>(patternjump-forward)
  silent! cmap <unique> <M-l> <Plug>(patternjump-forward)
endif

" backward
if !hasmapto('<Plug>(patternjump-backward)')
  silent! nmap <unique> <M-h> <Plug>(patternjump-backward)
  silent! xmap <unique> <M-h> <Plug>(patternjump-backward)
  silent! omap <unique> <M-h> <Plug>(patternjump-backward)
  silent! imap <unique> <M-h> <Plug>(patternjump-backward)
  silent! cmap <unique> <M-h> <Plug>(patternjump-backward)
endif


