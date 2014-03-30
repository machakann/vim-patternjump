" patternjump.vim - move cursor as you like

" I assumed that several dozen patterns are used usually, so I optimized for the use case.
" If defined patterns are too much, following algorithm might be slow.
" But if there is too much patterns, cursor would stop frequently, I guess it is nonsense.

" Actually if using searchpos() function, the descriptions would be easier and simpler.
" But I found that the present methods are faster.
" Anyway I want to make it responsive also in command-line mode. Thus I used followings.

let s:save_cpo = &cpo
set cpo&vim

" default patterns
let s:patternjump_patterns = {
      \ '_' : {
      \   'i' : {
      \     'head' : ['^\s*\zs\S', ',', ')', ']', '}'],
      \     'tail' : ['\<\h\k*\>', '.$'],
      \     },
      \   'n' : {
      \     'head' : ['^\s*\zs\S', '\<\h\k*\>', '.$'],
      \     },
      \   'x' : {
      \     'tail' : ['^\s*\zs\S', '\<\h\k*\>', '.$'],
      \     },
      \   'o' : {
      \     'forward'  : {'tail_inclusive' : ['\<\h\k*\>']},
      \     'backward' : {'head_inclusive' : ['\<\h\k*\>']},
      \     },
      \   },
      \ '*' : {
      \   'c' : {
      \     'head' : ['^', ' ', '[A-Z]', ',', ')', ']', '}', '$'],
      \     },
      \   },
      \ }

let s:type_num  = type(0)
let s:type_str  = type('')
let s:type_list = type([])
let s:type_dict = type({})

" load vital
let s:V  = vital#of('patternjump')
let s:Sl = s:V.import('Data.List')
unlet s:V

function! patternjump#forward(mode, ...) "{{{
  " count assignment
  let l:count = (a:0 > 1 && a:2 > 0) ? a:2 : v:count1

  " re-entering to the visual mode (if necessary)
  if (a:mode ==# 'x') && ((mode() !=? 'v') && (mode() != "\<C-v>"))
    normal! gv
    let current_mode = mode()
  endif

  " searching for user configurations
  let options_dict       = (a:0 > 2) ? a:3 : {}
  let opt_caching        = patternjump#user_conf(       'caching', options_dict, 0)
  let opt_debug_mode     = patternjump#user_conf(    'debug_mode', options_dict, 0)
  let opt_highlight      = patternjump#user_conf(     'highlight', options_dict, 0)
  let opt_cache_name     = patternjump#user_conf(    'cache_name', options_dict, 'b:patternjump_cache')
  let opt_swap_head_tail = patternjump#user_conf('swap_head_tail', options_dict, 0)
  let opt_ignore_case    = patternjump#user_conf(   'ignore_case', options_dict, 0)
  let opt_wrap_line      = patternjump#user_conf(     'wrap_line', options_dict, 1)
  let opt_move_afap      = patternjump#user_conf(     'move_afap', options_dict, 1)
  let opt_raw            = s:check_raw(options_dict)

  " case sensitivity
  let ignore_case = &ignorecase
  let &ignorecase = opt_ignore_case

  " check and modify cache name
  if opt_cache_name =~# '^\h[0-9a-zA-Z_#]*$'
    let cache_name = 'b:' . opt_cache_name
  elseif opt_cache_name =~# '^[^bgtw]:\h[0-9a-zA-Z_#]*$'
    let cache_name = 'b:' . opt_cache_name[2:]
  else
    let cache_name = opt_cache_name
  endif

  " resolve given patterns
  let pattern_lists = [[], []]

  if !opt_caching
    " do not use cache
    let patternjump_patterns = (a:0 > 0) ? a:1 : (exists('g:patternjump_patterns') ? g:patternjump_patterns : s:patternjump_patterns)

    if type(patternjump_patterns) == s:type_list
      let pattern_lists[0] = get(patternjump_patterns, 0, [])
      let pattern_lists[1] = get(patternjump_patterns, 1, [])
    elseif type(patternjump_patterns) == s:type_dict
      let pattern_lists = s:resolve_pattern_dictionary(a:mode, 'forward', patternjump_patterns)
    endif
  else
    " use cache
    if !exists(cache_name)
      " cache do not exist
      let patternjump_patterns = (a:0 > 0) ? a:1 : (exists('g:patternjump_patterns') ? g:patternjump_patterns : s:patternjump_patterns)

      if type(patternjump_patterns) == s:type_list
        let pattern_lists[0] = get(patternjump_patterns, 0, [])
        let pattern_lists[1] = get(patternjump_patterns, 1, [])
      elseif type(patternjump_patterns) == s:type_dict
        let pattern_lists = s:resolve_pattern_dictionary(a:mode, 'forward', patternjump_patterns)
      endif

      " make cache
      execute 'let ' . cache_name . ' = [{}, {}]'
      execute 'let ' . cache_name . '[0][a:mode] = pattern_lists'
    elseif !has_key(eval(eval('cache_name'))[0], a:mode)
      " cache for the current mode do not exist
      let patternjump_patterns = (a:0 > 0) ? a:1 : (exists('g:patternjump_patterns') ? g:patternjump_patterns : s:patternjump_patterns)

      if type(patternjump_patterns) == s:type_list
        let pattern_lists[0] = get(patternjump_patterns, 0, [])
        let pattern_lists[1] = get(patternjump_patterns, 1, [])
      elseif type(patternjump_patterns) == s:type_dict
        let pattern_lists = s:resolve_pattern_dictionary(a:mode, 'forward', patternjump_patterns)
      endif

      " add cache
      execute 'let ' . cache_name . '[0][a:mode] = pattern_lists'
    else
      " cache exists
      if a:0 > 0
        let patternjump_patterns = a:1

        if type(patternjump_patterns) == s:type_list
          let pattern_lists[0] = get(patternjump_patterns, 0, [])
          let pattern_lists[1] = get(patternjump_patterns, 1, [])
        elseif type(patternjump_patterns) == s:type_dict
          let pattern_lists = s:resolve_pattern_dictionary(a:mode, 'forward', patternjump_patterns)
        endif
      else
        execute 'let pattern_lists = ' . cache_name . '[0][a:mode]'
      endif
    endif
  endif

  " split into head and tail patterns
  let head_pattern_list = pattern_lists[0]
  let tail_pattern_list = pattern_lists[1]

  if a:mode == 'c'
    let string = getcmdline()
    let cursor = [0, getcmdpos()]
  else
    let string = getline('.')
    let cursor = [line('.'), col('.')]
    let fileend = line('$')
  endif

  " pattern swapping (only in visual mode)
  if (a:mode ==# 'x') && opt_swap_head_tail && ((current_mode ==# 'v') || (current_mode == "\<C-v>"))
    let counter_edge = [line("'<"), col("'<")]
    if counter_edge == cursor
      let counter_edge = [line("'>"), col("'>")]
    endif

    if (cursor[0] < counter_edge[0]) || ((cursor[0] == counter_edge[0]) && (cursor[1] < counter_edge[1]))
      let head_pattern_list = pattern_lists[1]
      let tail_pattern_list = pattern_lists[0]

      let swapped = 1
    else
      let swapped = 0
    endif
  else
    let swapped = -1
  endif

  " searching for candidate positions
  let marker     = copy(cursor)
  let candidates = []

  while 1
    let candidates += s:search_forward(a:mode, l:count, string, marker, head_pattern_list, tail_pattern_list, !(opt_debug_mode || opt_highlight), swapped)

    if (swapped == 1) && (candidates != []) && s:judge_swap('forward', swapped, candidates, l:count, counter_edge, opt_move_afap)
      let head_pattern_list = pattern_lists[0]
      let tail_pattern_list = pattern_lists[1]

      let swapped = 0
    elseif opt_wrap_line && (a:mode !=# 'c') && (len(candidates) < l:count)
      let marker[0] += 1
      if  marker[0] > fileend | break | endif
      let string = getline(marker[0])
      let marker[1]  = 0
    else
      break
    endif
  endwhile

  " remove unnecessary matched_patterns and candidates
  if swapped >= 0
    let filter  = '(v:val[3] == 1) && (((v:val[0][0] > counter_edge[0]) || (v:val[0][0] == counter_edge[0]) && (v:val[0][1] > counter_edge[1])))'
    let filter .= ' || ((v:val[3] == 0) && ((v:val[0][0] < counter_edge[0]) || ((v:val[0][0] == counter_edge[0]) && (v:val[0][1] < counter_edge[1]))))'
    let filter .= ' ? [] : v:val'
    call filter(map(candidates, filter), 'v:val != []')
  endif

  " determine output and move cursor
  let candidates_uniq = sort(s:Sl.uniq_by(copy(candidates), 'v:val[0]'), "s:compare")
  let dest = get(candidates_uniq, l:count-1, [[-1, -1], '', '', -1])
  if (dest == [[-1, -1], '', '', -1]) && opt_move_afap && (candidates_uniq != [])
    let dest = candidates_uniq[-1]
  endif

  let output = ''
  if !empty(candidates) && (dest[0][1] > 0)
    if opt_raw != 1
      if !opt_debug_mode
        if a:mode =~# '[nxi]'
          call cursor(dest[0])
        elseif a:mode ==# 'o'
          if dest[2] =~# '\%(head\|tail\)_inclusive'
            normal! v
          endif

          call cursor(dest[0])
        elseif a:mode ==# 'c'
          call setcmdpos(dest[0][1])
        endif
      endif
    endif
  endif

  if opt_raw
    " raw mode
    unlet output
    let output = {}
    let output.destination = dest
    let output.candidates  = candidates
  endif

  " highlighting candidates (if necessary)
  if (opt_debug_mode || opt_highlight) && (a:mode =~# '[nxi]')
    call s:highlighter(candidates, opt_debug_mode)
  endif

  " get back original settings
  let &ignorecase = ignore_case

  return output
endfunction
"}}}
function! s:search_forward(mode, count, string, marker, head_pattern_list, tail_pattern_list, collect_all, swapped) "{{{
  let candidates = []
  let len        = len(a:string)

  " resolve head_pattern_list and tail_pattern_list
  if type(get(a:head_pattern_list, 0, [])) == s:type_list
    let head_pattern_list = get(a:head_pattern_list, 0, [])
  elseif type(get(a:head_pattern_list, 0, [])) == s:type_str
    let head_pattern_list = [a:head_pattern_list[0]]
  else
    let head_pattern_list = []
  endif

  if type(get(a:tail_pattern_list, 0, [])) == s:type_list
    let tail_pattern_list = get(a:tail_pattern_list, 0, [])
  elseif type(get(a:tail_pattern_list, 0, [])) == s:type_str
    let tail_pattern_list = [a:tail_pattern_list[0]]
  else
    let tail_pattern_list = []
  endif

  if a:mode ==# 'o'
    if type(get(a:head_pattern_list, 1, [])) == s:type_list
      let head_inclusive_pattern_list = get(a:head_pattern_list, 1, [])
    else
      let head_inclusive_pattern_list = []
    endif

    if type(get(a:tail_pattern_list, 1, [])) == s:type_list
      let tail_inclusive_pattern_list = get(a:tail_pattern_list, 1, [])
    else
      let tail_inclusive_pattern_list = []
    endif
  endif

  " scan head patterns
  for pattern in head_pattern_list
    let Nth = 0
    let previous_pos = -1
    while 1
      let Nth += 1
      let matched_pos = match(a:string, pattern, 0, Nth)
      let matched_pos = ((matched_pos >= 0) && ((a:mode =~# '[ci]') || ((a:mode =~# '[nxo]') && (!(matched_pos == len) || ((matched_pos == 0) && (len == 0)))))) ? (matched_pos + 1) : matched_pos
      if matched_pos < 0 | break | endif

      " counter measure for special patterns like '$'
      " patched! : Vim 7.4.184
      " &encoding == cp932
      if matched_pos > (((a:mode =~# '[ci]') || (len == 0)) ? (len + 1) : len) | break | endif
      " &encoding == utf-8
      if matched_pos == previous_pos | break | endif
      let previous_pos = matched_pos

      if (matched_pos > a:marker[1]) || ((matched_pos == 0) && (a:marker[1] == 0))
        let candidates += [[[a:marker[0], matched_pos], pattern, 'head', a:swapped]]

        if (a:count == 1) && !a:collect_all
          break
        else
          continue
        endif
      endif
    endwhile
  endfor

  " scan tail patterns
  for pattern in tail_pattern_list
    let Nth = 0
    let previous_pos = -1
    while 1
      let Nth += 1
      let matched_pos = matchend(a:string, pattern, 0, Nth)
      let matched_pos = ((matched_pos == 0) || ((a:mode =~# '[ic]') && (matched_pos > 0))) ? (matched_pos + 1) : matched_pos
      if matched_pos < 0 | break | endif

      " counter measure for special patterns like '$'
      " patched! : Vim 7.4.184
      " &encoding == cp932
      if matched_pos > (((a:mode =~# '[ci]') || (len == 0)) ? (len + 1) : len) | break | endif
      " &encoding == utf-8
      if matched_pos == previous_pos | break | endif
      let previous_pos = matched_pos

      if matched_pos > a:marker[1]
        let candidates += [[[a:marker[0], matched_pos], pattern, 'tail', a:swapped]]

        if (a:count == 1) && !a:collect_all
          break
        else
          continue
        endif
      endif
    endwhile
  endfor

  if a:mode ==# 'o'
    " scan head_inclusive patterns
    for pattern in head_inclusive_pattern_list
      let Nth = 0
      let previous_pos = -1
      while 1
        let Nth += 1
        let matched_pos = match(a:string, pattern, 0, Nth)
        let matched_pos = ((matched_pos >= 0) && ((a:mode =~# '[ci]') || ((a:mode =~# '[nxo]') && (!(matched_pos == len) || ((matched_pos == 0) && (len == 0)))))) ? (matched_pos + 1) : matched_pos
        if matched_pos < 0 | break | endif

        " counter measure for special patterns like '$'
        " patched! : Vim 7.4.184
        " &encoding == cp932
        if matched_pos > (((a:mode =~# '[ci]') || (len == 0)) ? (len + 1) : len) | break | endif
        " &encoding == utf-8
        if matched_pos == previous_pos | break | endif
        let previous_pos = matched_pos

        if matched_pos > a:marker[1]
          let candidates += [[[a:marker[0], matched_pos], pattern, 'head_inclusive', a:swapped]]

          if (a:count == 1) && !a:collect_all
            break
          else
            continue
          endif
        endif
      endwhile
    endfor

    " scan tail_inclusive patterns
    for pattern in tail_inclusive_pattern_list
      let Nth = 0
      let previous_pos = -1
      while 1
        let Nth += 1
        let matched_pos = matchend(a:string, pattern, 0, Nth)
        let matched_pos = ((matched_pos == 0) || ((a:mode =~# '[ic]') && (matched_pos >= 0))) ? (matched_pos + 1) : matched_pos
        if matched_pos < 0 | break | endif

        " counter measure for special patterns like '$'
        " patched! : Vim 7.4.184
        " &encoding == cp932
        if matched_pos > (((a:mode =~# '[ci]') || (len == 0)) ? (len + 1) : len) | break | endif
        " &encoding == utf-8
        if matched_pos == previous_pos | break | endif
        let previous_pos = matched_pos

        if matched_pos > a:marker[1]
          let candidates += [[[a:marker[0], matched_pos], pattern, 'tail_inclusive', a:swapped]]

          if (a:count == 1) && !a:collect_all
            break
          else
            continue
          endif
        endif
      endwhile
    endfor
  endif

  return candidates
endfunction
"}}}
function! patternjump#backward(mode, ...) "{{{
  " resolve count assignment
  let l:count = (a:0 > 1 && a:2 > 0) ? a:2 : v:count1

  " re-entering to the visual mode (if necessary)
  if (a:mode ==# 'x') && ((mode() !=? 'v') && (mode() != "\<C-v>"))
    normal! gv
    let current_mode = mode()
  endif

  " searching for user configurations
  let options_dict       = (a:0 > 2) ? a:3 : {}
  let opt_caching        = patternjump#user_conf(       'caching', options_dict, 0)
  let opt_debug_mode     = patternjump#user_conf(    'debug_mode', options_dict, 0)
  let opt_highlight      = patternjump#user_conf(     'highlight', options_dict, 0)
  let opt_cache_name     = patternjump#user_conf(    'cache_name', options_dict, 'b:patternjump_cache')
  let opt_swap_head_tail = patternjump#user_conf('swap_head_tail', options_dict, 0)
  let opt_ignore_case    = patternjump#user_conf(   'ignore_case', options_dict, 0)
  let opt_wrap_line      = patternjump#user_conf(     'wrap_line', options_dict, 1)
  let opt_move_afap      = patternjump#user_conf(     'move_afap', options_dict, 1)
  let opt_raw            = s:check_raw(options_dict)

  " case sensitivity
  let ignore_case = &ignorecase
  let &ignorecase = opt_ignore_case

  " check and modify cache name
  if opt_cache_name =~# '^\h[0-9a-zA-Z_#]*$'
    let cache_name = 'b:' . opt_cache_name
  elseif opt_cache_name =~# '^[^bgtw]:\h[0-9a-zA-Z_#]*$'
    let cache_name = 'b:' . opt_cache_name[2:]
  else
    let cache_name = opt_cache_name
  endif

  " resolve given patterns
  let pattern_lists = [[], []]

  if !opt_caching
    " do not use cache
    let patternjump_patterns = (a:0 > 0) ? a:1 : (exists('g:patternjump_patterns') ? g:patternjump_patterns : s:patternjump_patterns)

    if type(patternjump_patterns) == s:type_list
      let pattern_lists[0] = get(patternjump_patterns, 0, [])
      let pattern_lists[1] = get(patternjump_patterns, 1, [])
    elseif type(patternjump_patterns) == s:type_dict
      let pattern_lists = s:resolve_pattern_dictionary(a:mode, 'backward', patternjump_patterns)
    endif
  else
    " use cache
    if !exists(cache_name)
      " cache do not exist
      let patternjump_patterns = (a:0 > 0) ? a:1 : (exists('g:patternjump_patterns') ? g:patternjump_patterns : s:patternjump_patterns)

      if type(patternjump_patterns) == s:type_list
        let pattern_lists[0] = get(patternjump_patterns, 0, [])
        let pattern_lists[1] = get(patternjump_patterns, 1, [])
      elseif type(patternjump_patterns) == s:type_dict
        let pattern_lists = s:resolve_pattern_dictionary(a:mode, 'backward', patternjump_patterns)
      endif

      " make cache
      execute 'let ' . cache_name . ' = [{}, {}]'
      execute 'let ' . cache_name . '[0][a:mode] = pattern_lists'
    elseif !has_key(eval(eval('cache_name'))[0], a:mode)
      " cache for the current mode do not exist
      let patternjump_patterns = (a:0 > 0) ? a:1 : (exists('g:patternjump_patterns') ? g:patternjump_patterns : s:patternjump_patterns)

      if type(patternjump_patterns) == s:type_list
        let pattern_lists[0] = get(patternjump_patterns, 0, [])
        let pattern_lists[1] = get(patternjump_patterns, 1, [])
      elseif type(patternjump_patterns) == s:type_dict
        let pattern_lists = s:resolve_pattern_dictionary(a:mode, 'backward', patternjump_patterns)
      endif

      " add cache
      execute 'let ' . cache_name . '[0][a:mode] = pattern_lists'
    else
      " cache exists
      if a:0 > 0
        let patternjump_patterns = a:1

        if type(patternjump_patterns) == s:type_list
          let pattern_lists[0] = get(patternjump_patterns, 0, [])
          let pattern_lists[1] = get(patternjump_patterns, 1, [])
        elseif type(patternjump_patterns) == s:type_dict
          let pattern_lists = s:resolve_pattern_dictionary(a:mode, 'forward', patternjump_patterns)
        endif
      else
        execute 'let pattern_lists = ' . cache_name . '[0][a:mode]'
      endif
    endif
  endif

  " split into head and tail patterns
  let head_pattern_list = pattern_lists[0]
  let tail_pattern_list = pattern_lists[1]

  if a:mode == 'c'
    let string = getcmdline()
    let cursor = [0, getcmdpos()]
  else
    let string = getline('.')
    let cursor = [line('.'), col('.')]
  endif

  " pattern swapping (only in visual mode)
  if (a:mode ==# 'x') && opt_swap_head_tail && ((current_mode ==# 'v') || (current_mode == "\<C-v>"))
    let counter_edge = [line("'>"), col("'>")]
    if counter_edge == cursor
      let counter_edge = [line("'<"), col("'<")]
    endif

    if ((cursor[0] < counter_edge[0]) || ((cursor[0] == counter_edge[0]) && (cursor[1] <= counter_edge[1])))
      let head_pattern_list = pattern_lists[1]
      let tail_pattern_list = pattern_lists[0]

      let swapped = 1
    else
      let swapped = 0
    endif
  else
    let swapped = -1
  endif

  " searching for candidate positions
  let marker     = copy(cursor)
  let candidates = []

  while 1
    let candidates += s:search_backward(a:mode, string, marker, head_pattern_list, tail_pattern_list, swapped)

    if (swapped == 0) && (candidates != []) && s:judge_swap('backward', swapped, candidates, l:count, counter_edge, opt_move_afap)
      let head_pattern_list = pattern_lists[1]
      let tail_pattern_list = pattern_lists[0]

      let swapped = 1
    elseif opt_wrap_line && (a:mode !=# 'c') && (len(candidates) < l:count)
      let marker[0] -= 1
      if  marker[0] < 1 | break | endif
      let string = getline(marker[0])
      let marker[1]  = len(string) + 2
    else
      break
    endif
  endwhile

  " remove unnecessary matched_patterns and candidates
  if swapped >= 0
    let filter  = '(v:val[3] == 1) && (((v:val[0][0] > counter_edge[0]) || (v:val[0][0] == counter_edge[0]) && (v:val[0][1] > counter_edge[1])))'
    let filter .= ' || ((v:val[3] == 0) && ((v:val[0][0] < counter_edge[0]) || ((v:val[0][0] == counter_edge[0]) && (v:val[0][1] < counter_edge[1]))))'
    let filter .= ' ? [] : v:val'
    call filter(map(candidates, filter), 'v:val != []')
  endif

  " determine output or move cursor
  let candidates_uniq = reverse(sort(s:Sl.uniq_by(copy(candidates), 'v:val[0]'), "s:compare"))
  let dest = get(candidates_uniq, l:count-1, [[-1, -1], '', '', -1])
  if (dest == [[-1, -1], '', '', -1]) && opt_move_afap && (candidates_uniq != [])
    let dest = candidates_uniq[-1]
  endif

  let output = ''
  if !empty(candidates) && (dest[0][1] > 0)
    if opt_raw != 1
      if !opt_debug_mode
        if a:mode =~# '[nxi]'
          call cursor(dest[0])
        elseif a:mode ==# 'o'
          if dest[2] =~# '\%(head\|tail\)_inclusive'
            normal! v
          endif

          call cursor(dest[0])
        elseif a:mode ==# 'c'
          call setcmdpos(dest[0][1])
        endif
      endif
    endif
  endif

  if opt_raw
    " raw mode
    unlet output
    let output = {}
    let output.column     = dest
    let output.candidates = candidates
  endif

  " highlighting candidates (if necessary)
  if (opt_debug_mode || opt_highlight) && (a:mode =~# '[nxi]')
    call s:highlighter(candidates, opt_debug_mode)
  endif

  " get back original settings
  let &ignorecase = ignore_case

  return output
endfunction
"}}}
function! s:search_backward(mode, string, marker, head_pattern_list, tail_pattern_list, swapped)  "{{{
  let candidates = []
  let len        = len(a:string) + 1

  " resolve head_pattern_list and tail_pattern_list
  if type(get(a:head_pattern_list, 0, [])) == s:type_list
    let head_pattern_list = get(a:head_pattern_list, 0, [])
  elseif type(get(a:head_pattern_list, 0, [])) == s:type_str
    let head_pattern_list = [a:head_pattern_list[0]]
  else
    let head_pattern_list = []
  endif

  if type(get(a:tail_pattern_list, 0, [])) == s:type_list
    let tail_pattern_list = get(a:tail_pattern_list, 0, [])
  elseif type(get(a:tail_pattern_list, 0, [])) == s:type_str
    let tail_pattern_list = [a:tail_pattern_list[0]]
  else
    let tail_pattern_list = []
  endif

  if a:mode ==# 'o'
    if type(get(a:head_pattern_list, 1, [])) == s:type_list
      let head_inclusive_pattern_list = get(a:head_pattern_list, 1, [])
    else
      let head_inclusive_pattern_list = []
    endif

    if type(get(a:tail_pattern_list, 1, [])) == s:type_list
      let tail_inclusive_pattern_list = get(a:tail_pattern_list, 1, [])
    else
      let tail_inclusive_pattern_list = []
    endif
  endif

  " scan head patterns
  for pattern in head_pattern_list
    let Nth = 0
    let previous_pos = -1
    while 1
      let Nth += 1
      let matched_pos = match(a:string, pattern, 0, Nth)
      let matched_pos = ((matched_pos >= 0) && ((a:mode =~# '[ci]') || ((a:mode =~# '[nxo]') && (!(matched_pos == len) || ((matched_pos == 0) && (len == 0)))))) ? (matched_pos + 1) : matched_pos
      if (matched_pos < 0) || (matched_pos >= a:marker[1]) | break | endif

      " counter measure for special patterns like '$'
      " patched! : Vim 7.4.184
      " &encoding == cp932
      if matched_pos > (((a:mode =~# '[ci]') || (len == 0)) ? (len + 1) : len) | break | endif
      " &encoding == utf-8
      if matched_pos == previous_pos | break | endif
      let previous_pos = matched_pos

      let candidates += [[[a:marker[0], matched_pos], pattern, 'head', a:swapped]]
    endwhile
  endfor

  " scan tail patterns
  for pattern in tail_pattern_list
    let Nth = 0
    let previous_pos = -1
    while 1
      let Nth += 1
      let matched_pos = matchend(a:string, pattern, 0, Nth)
      let matched_pos = ((matched_pos == 0) || ((a:mode =~# '[ic]') && (matched_pos > 0))) ? (matched_pos + 1) : matched_pos
      if (matched_pos < 0) || (matched_pos >= a:marker[1]) | break | endif

      " counter measure for special patterns like '$'
      " patched! : Vim 7.4.184
      " &encoding == cp932
      if matched_pos > (((a:mode =~# '[ci]') || (len == 0)) ? (len + 1) : len) | break | endif
      " &encoding == utf-8
      if matched_pos == previous_pos | break | endif
      let previous_pos = matched_pos

      let candidates += [[[a:marker[0], matched_pos], pattern, 'tail', a:swapped]]
    endwhile
  endfor

  if a:mode ==# 'o'
    " scan head_inclusive patterns
    for pattern in head_inclusive_pattern_list
      let Nth = 0
      let previous_pos = -1
      while 1
        let Nth += 1
        let matched_pos = match(a:string, pattern, 0, Nth)
        let matched_pos = ((matched_pos >= 0) && ((a:mode =~# '[ci]') || ((a:mode =~# '[nxo]') && (!(matched_pos == len) || ((matched_pos == 0) && (len == 0)))))) ? (matched_pos + 1) : matched_pos
        if (matched_pos < 0) || (matched_pos >= a:marker[1]) | break | endif

        " counter measure for special patterns like '$'
        " patched! : Vim 7.4.184
        " &encoding == cp932
        if matched_pos > (((a:mode =~# '[ci]') || (len == 0)) ? (len + 1) : len) | break | endif
        " &encoding == utf-8
        if matched_pos == previous_pos | break | endif
        let previous_pos = matched_pos

        let candidates += [[[a:marker[0], matched_pos], pattern, 'head_inclusive', a:swapped]]
      endwhile
    endfor

    " scan tail_inclusive patterns
    for pattern in tail_inclusive_pattern_list
      let Nth = 0
      let previous_pos = -1
      while 1
        let Nth += 1
        let matched_pos = matchend(a:string, pattern, 0, Nth)
        let matched_pos = ((matched_pos == 0) || ((a:mode =~# '[ic]') && (matched_pos >= 0))) ? (matched_pos + 1) : matched_pos
        if (matched_pos < 0) || (matched_pos >= a:marker[1]) | break | endif

        " counter measure for special patterns like '$'
        " patched! : Vim 7.4.184
        " &encoding == cp932
        if matched_pos > (((a:mode =~# '[ci]') || (len == 0)) ? (len + 1) : len) | break | endif
        " &encoding == utf-8
        if matched_pos == previous_pos | break | endif
        let previous_pos = matched_pos

        let candidates += [[[a:marker[0], matched_pos], pattern, 'tail_inclusive', a:swapped]]
      endwhile
    endfor
  endif

  return candidates
endfunction
"}}}
function! patternjump#user_conf(name, arg, default)    "{{{
  let user_conf = a:default

  if has_key(a:arg, a:name)
    return a:arg[a:name]
  endif

  if exists('g:patternjump_' . a:name)
    let user_conf = g:patternjump_{a:name}
  endif

  if exists('t:patternjump_' . a:name)
    let user_conf = t:patternjump_{a:name}
  endif

  if exists('w:patternjump_' . a:name)
    let user_conf = w:patternjump_{a:name}
  endif

  if exists('b:patternjump_' . a:name)
    let user_conf = b:patternjump_{a:name}
  endif

  return user_conf
endfunction
"}}}
function! s:check_raw(arg)    "{{{
  if has_key(a:arg, 'raw')
    return a:arg['raw']
  endif

  return 0
endfunction
"}}}
function! s:resolve_pattern_dictionary(mode, direction, patternjump_patterns) "{{{
  " resolving patternjump_patterns and extracting requred patterns
  let keys = keys(a:patternjump_patterns)
  let matched_key = get(filter(keys, 'v:val ==# "' . &filetype . '"'), 0, [])
  if !empty(matched_key)
    let include_list = [matched_key]
    if has_key(a:patternjump_patterns[matched_key], 'include')
      if type(a:patternjump_patterns[matched_key].include) == s:type_str
        if a:patternjump_patterns[matched_key].include != matched_key
          let include_list += [a:patternjump_patterns[matched_key].include]
        endif
      elseif type(a:patternjump_patterns[matched_key].include) == s:type_list
        let include_list += s:Sl.uniq_by(filter(copy(a:patternjump_patterns[matched_key].include), 'v:val != matched_key'), 'v:val')
      endif
    endif
  else
    let include_list = ['_']
  endif

  " always include '*' key if it exists
  if has_key(a:patternjump_patterns, '*')
    let include_list += ['*']
  endif

  let head_pattern_list = [[], []]
  let tail_pattern_list = [[], []]
  for key in include_list
    let temp = get(a:patternjump_patterns, key, [])

    " checking whether there are mode specific patterns or not
    if type(temp) == s:type_dict
      let keys = filter(keys(temp), 'v:val !~# ''\%(common\|forward\|backward\|head\|tail\|include\)''')
      let idx  = match(keys, '.*' . a:mode . '.*')
      if idx >= 0
        let pattern_info = temp[keys[idx]]
      else
        let pattern_info = temp
      endif
    else
      let pattern_info = temp
    endif
    unlet temp

    if type(pattern_info) == s:type_list
      let head_pattern_list[0] += pattern_info
    elseif type(pattern_info) == s:type_dict
      let common    = has_key(pattern_info,    'common')
      let direction = has_key(pattern_info, a:direction)
      let head      = has_key(pattern_info,      'head')
      let tail      = has_key(pattern_info,      'tail')
      let head_inclusive = has_key(pattern_info, 'head_inclusive')
      let tail_inclusive = has_key(pattern_info, 'tail_inclusive')

      if common || direction
        if common
          if type(pattern_info.common) == s:type_list
            let head_pattern_list[0] += pattern_info.common
          elseif type(pattern_info.common) == s:type_dict
            if has_key(pattern_info.common, 'head')
              if type(pattern_info.common.head) == s:type_list
                let head_pattern_list[0] += pattern_info.common.head
              endif
            endif

            if has_key(pattern_info.common, 'tail')
              if type(pattern_info.common.tail) == s:type_list
                let tail_pattern_list[0] += pattern_info.common.tail
              endif
            endif

            " only in operator-pending mode (code for inclusive motion)
            if a:mode ==# 'o'
              if has_key(pattern_info.common, 'head_inclusive')
                if type(pattern_info.common.head_inclusive) == s:type_list
                  let head_pattern_list[1] += pattern_info.common.head_inclusive
                endif
              endif

              if has_key(pattern_info.common, 'tail_inclusive')
                if type(pattern_info.common.tail_inclusive) == s:type_list
                  let tail_pattern_list[1] += pattern_info.common.tail_inclusive
                endif
              endif
            endif
          endif
        endif

        if direction
          if type(pattern_info[a:direction]) == s:type_list
            let head_pattern_list[0] += pattern_info[a:direction]
          elseif type(pattern_info[a:direction]) == s:type_dict
            if has_key(pattern_info[a:direction], 'head')
              if type(pattern_info[a:direction].head) == s:type_list
                let head_pattern_list[0] += pattern_info[a:direction].head
              endif
            endif

            if has_key(pattern_info[a:direction], 'tail')
              if type(pattern_info[a:direction].tail) == s:type_list
                let tail_pattern_list[0] += pattern_info[a:direction].tail
              endif
            endif

            " only in operator-pending mode (code for inclusive motion)
            if a:mode ==# 'o'
              if has_key(pattern_info[a:direction], 'head_inclusive')
                if type(pattern_info[a:direction].head_inclusive) == s:type_list
                  let head_pattern_list[1] += pattern_info[a:direction].head_inclusive
                endif
              endif

              if has_key(pattern_info[a:direction], 'tail_inclusive')
                if type(pattern_info[a:direction].tail_inclusive) == s:type_list
                  let tail_pattern_list[1] += pattern_info[a:direction].tail_inclusive
                endif
              endif
            endif
          endif
        endif
      elseif head || tail || head_inclusive || tail_inclusive
        if head
          if type(pattern_info.head) == s:type_list
            let head_pattern_list[0] += pattern_info.head
          endif
        endif

        if tail
          if type(pattern_info.tail) == s:type_list
            let tail_pattern_list[0] += pattern_info.tail
          endif
        endif

        " only in operator-pending mode (code for inclusive motion)
        if a:mode ==# 'o'
          if head_inclusive
            if type(pattern_info.head_inclusive) == s:type_list
              let head_pattern_list[1] += pattern_info.head_inclusive
            endif
          endif

          if tail_inclusive
            if type(pattern_info.tail_inclusive) == s:type_list
              let tail_pattern_list[1] += pattern_info.tail_inclusive
            endif
          endif
        endif
      endif
    endif

    unlet pattern_info
  endfor

  return [head_pattern_list, tail_pattern_list]
endfunction
"}}}
function! s:compare(i1, i2) "{{{
  if a:i1[0][0] < a:i2[0][0]
    return -1
  elseif a:i1[0][0] > a:i2[0][0]
    return 1
  else
    if a:i1[0][1] < a:i2[0][1]
      return -1
    elseif a:i1[0][1] > a:i2[0][1]
      return 1
    else
      return 0
    endif
  endif
endfunction
"}}}
function! s:judge_swap(direction, swapped, candidates, count, counter_edge, opt_move_afap) "{{{
  if a:direction ==# 'forward'
    let candidates_uniq = sort(s:Sl.uniq_by(copy(a:candidates), 'v:val[0]'), "s:compare")
    let dest = get(candidates_uniq, a:count-1, [[-1, -1], '', '', -1])
    if (dest == [[-1, -1], '', '', -1]) && a:opt_move_afap
      let dest = candidates_uniq[-1]
    endif

    if (dest[0][0] > a:counter_edge[0]) || ((dest[0][0] == a:counter_edge[0]) && (dest[0][1] > a:counter_edge[1]))
      return 1
    else
      return 0
    endif
  elseif a:direction ==# 'backward'
    let candidates_uniq = reverse(sort(s:Sl.uniq_by(copy(a:candidates), 'v:val[0]'), "s:compare"))
    let dest = get(candidates_uniq, a:count-1, [[-1, -1], '', '', -1])
    if (dest == [[-1, -1], '', '', -1]) && a:opt_move_afap
      let dest = candidates_uniq[-1]
    endif


    if (dest[0][0] < a:counter_edge[0]) || ((dest[0][0] == a:counter_edge[0]) && (dest[0][1] < a:counter_edge[1]))
      return 1
    else
      return 0
    endif
  endif
endfunction
"}}}
function! s:highlighter(candidates, opt_debug_mode) "{{{
  if !exists('b:patternjump')
    let b:patternjump       = {}
    let b:patternjump.state = 0
    let b:patternjump.id    = []
  endif

  if !empty(b:patternjump.id)
    let b:patternjump.state = 2
    call s:cleaner()
  endif

  if a:candidates != []
    " highlighting candidates
    let b:patternjump.id = map(copy(a:candidates), "s:highlight_add(v:val[0])")
    redraw

    " echo information
    if a:opt_debug_mode
      echomsg 'patternjump debug mode'
      for idx in range(len(a:candidates))
        echomsg printf('%d, %d, ''%s'', %s, %s', a:candidates[idx][0][0], a:candidates[idx][0][1], a:candidates[idx][1], a:candidates[idx][2], a:candidates[idx][3])
      endfor
      echomsg ''
    endif

    let b:patternjump.state = a:opt_debug_mode ? 2 : 1

    " reserving cleaner
    augroup patternjump:cleaner
      au!
      au CursorMoved,CursorMovedI,WinLeave <buffer> call s:cleaner()
    augroup END
  endif
endfunction
"}}}
function! s:highlight_add(pos) "{{{
  let pattern   = '\%' . a:pos[0] . 'l\%' . a:pos[1] . 'c.'
  let id = matchadd("IncSearch", pattern)
  return id
endfunction
"}}}
function! s:cleaner() "{{{
  if b:patternjump.state == 1
    let b:patternjump.state = 2
  else
    " delete highlighting
    call filter(map(b:patternjump.id, "s:highlight_del(v:val)"), 'v:val > 0')
    redraw

    if b:patternjump.id == []
      let b:patternjump.state = 0

      augroup patternjump:cleaner
        au!
      augroup END
    endif
  endif
endfunction
"}}}
function! s:highlight_del(id) "{{{
  let result = matchdelete(a:id)

  let output = (result == 0) ? result : a:id
  return output
endfunction
"}}}

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set foldmethod=marker:
" vim:set commentstring="%s:
