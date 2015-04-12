" patternjump.vim - move cursor as you like

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
      \     'head' : ['^', ' ', '/', '[A-Z]', ',', ')', ']', '}', '$'],
      \     },
      \   },
      \ }

let s:type_str  = type('')
let s:type_list = type([])
let s:type_dict = type({})
let s:null_pos  = [0, 0]
let s:null_candidate = [[-1, -1], '', '']
let s:stride = &lines

function! patternjump#forward(mode, ...) abort "{{{
  return s:prototype('forward', a:mode, a:0, a:000)
endfunction
"}}}
function! patternjump#backward(mode, ...) abort "{{{
  return s:prototype('backward', a:mode, a:0, a:000)
endfunction
"}}}
function! s:prototype(direction, mode, argn, args) abort  "{{{
  " count assignment
  if a:mode =~# '[ci]'
    let l:count = 1
  else
    let l:count = (a:argn > 1 && a:args[1] > 0) ? a:args[1] : v:count1
  endif

  " re-entering to the visual mode (if necessary)
  if (a:mode ==# 'x')
    let current_mode = mode()

    if (current_mode !=? 'v') && (current_mode !=# "\<C-v>")
      normal! gv
    endif
  endif

  " searching for user configurations
  let opt             = {}
  let options_dict    = (a:argn > 2) ? a:args[2] : {}
  let opt.ignorecase = s:user_conf('ignorecase', options_dict, 0)
  let opt.caching    = s:user_conf(   'caching', options_dict, 0)
  let opt.timeout    = s:user_conf(   'timeout', options_dict, 1000)
  let opt.highlight  = s:user_conf( 'highlight', options_dict, 0)
  let opt.debug_mode = s:user_conf('debug_mode', options_dict, 0)
  let opt.raw        = s:check_raw(options_dict)

  let output = ''
  let view   = winsaveview()

  let patternjump_patterns = a:argn > 0 ? a:args[0]
                  \ : exists('g:patternjump_patterns') ? g:patternjump_patterns
                  \ : s:patternjump_patterns

  if type(patternjump_patterns) == s:type_list
    let pattern_lists = patternjump_patterns
  elseif type(patternjump_patterns) == s:type_dict
    if !opt.caching
      " do not use cache
      let pattern_lists = s:resolve_pattern_dictionary(a:direction, a:mode, deepcopy(patternjump_patterns))
    else
      " use cache
      if !exists('b:patternjump')
        call s:init_storage()
      endif

      let hash = sha256(string(patternjump_patterns))
      if !has_key(b:patternjump['cache'], hash)
        " cache do not exist
        let pattern_lists = s:resolve_pattern_dictionary(a:direction, a:mode, deepcopy(patternjump_patterns))
        " make cache
        let b:patternjump['cache'][hash] = {'forward': {}, 'backward': {}}
        let b:patternjump['cache'][hash][a:direction][a:mode] = pattern_lists
      elseif !has_key(b:patternjump['cache'][hash][a:direction], a:mode)
        " cache for the current mode do not exist
        let pattern_lists = s:resolve_pattern_dictionary(a:direction, a:mode, deepcopy(patternjump_patterns))
        " add cache
        let b:patternjump['cache'][hash][a:direction][a:mode] = pattern_lists
      else
        " cache exists
        let pattern_lists = b:patternjump['cache'][hash][a:direction][a:mode]
      endif
    endif
  else
  endif

  " gather candidates
  let ignorecase  = &ignorecase
  let &ignorecase = opt.ignorecase
  try
    let candidates = s:gather_candidates_{a:mode}(a:direction, l:count, pattern_lists, opt)
  finally
    " get back original settings
    let &ignorecase = ignorecase
    " restore view
    call winrestview(view)
  endtry

  " determine output and move cursor
  let dest = s:elect(a:direction, l:count, candidates)

  if dest != s:null_candidate
    if opt.raw != 1
      if !opt.debug_mode
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

  if opt.raw
    " raw mode
    unlet output
    let output = {}
    let output.destination = dest
    let output.candidates  = candidates
  endif

  " highlighting candidates (if necessary)
  if (opt.debug_mode || opt.highlight) && (a:mode =~# '[nxi]')
    call s:highlighter(candidates, opt)
  endif

  return output
endfunction
"}}}
function! s:gather_candidates_n(direction, count, pattern_lists, opt) abort  "{{{
  return s:gather_candidates(a:direction, 'n', a:count, a:pattern_lists[0], 0, a:opt)
endfunction
"}}}
function! s:gather_candidates_i(direction, count, pattern_lists, opt) abort "{{{
  return s:gather_candidates(a:direction, 'i', a:count, a:pattern_lists[0], 0, a:opt)
endfunction
"}}}
function! s:gather_candidates_x(direction, count, pattern_lists, opt) abort  "{{{
  return s:gather_candidates(a:direction, 'x', a:count, a:pattern_lists[0], 0, a:opt)
endfunction
"}}}
function! s:gather_candidates_o(direction, count, pattern_lists, opt) abort "{{{
  let candidates  = []
  " NOTE: Search inclusive pattern first, because if both cases has same
  "       pattern the inclusive pattern should have proirity. I note that
  "       's:uniq_by' keeps the first occurrence.
  let candidates += s:gather_candidates(a:direction, 'o', a:count, a:pattern_lists[1], 1, a:opt)
  let candidates += s:gather_candidates(a:direction, 'o', a:count, a:pattern_lists[0], 0, a:opt)
  return candidates
endfunction
"}}}
function! s:gather_candidates_c(direction, count, pattern_lists, opt) abort  "{{{
  let candidates = []
  let cmdline    = getcmdline()
  let cmdpos     = getcmdpos()
  let len        = strlen(cmdline)

  let head_pattern_list = a:pattern_lists[0][0]
  let tail_pattern_list = a:pattern_lists[0][1]

  " NOTE: Do not use the third argument of match() function!
  "       Because the pattern '^' always matches with same point as it gives.
  "       That is, match(string, '^', pos) always returns pos.
  for [side, Match_func] in [
        \  ['head', function('match')],
        \  ['tail', function('matchend')],
        \ ]
    for pattern in {side}_pattern_list
      let Nth = 0
      let previous_pos = -1
      while 1
        let Nth += 1
        let matched_pos = Match_func(cmdline, pattern, 0, Nth)
        let matched_pos = matched_pos >= 0 ? matched_pos+1 : matched_pos
        if matched_pos < 0 | break | endif

        " counter measure for special patterns like '$'
        " patched! : Vim 7.4.184
        " &encoding == cp932
        if matched_pos > len + 1 | break | endif
        " &encoding == utf-8
        if matched_pos == previous_pos | break | endif
        let previous_pos = matched_pos

        if (a:direction ==#  'forward' && matched_pos > cmdpos) ||
         \ (a:direction ==# 'backward' && matched_pos < cmdpos)
          let candidates += [[[0, matched_pos], pattern, side]]
        else
          continue
        endif
      endwhile
    endfor
  endfor

  return candidates
endfunction
"}}}
function! s:gather_candidates(direction, mode, count, lists, is_inc, opt) abort  "{{{
  let candidates = []
  let cur_pos    = getpos('.')

  " determine 'stopline' and 'flag' to search for candidates
  if a:direction ==# 'forward'
    let searchend = line('$')
    let stopline  = line('w$')
    let stride    = s:stride
    let flag_head = ''
    let flag_tail = 'e'
  elseif a:direction ==# 'backward'
    let searchend = 1
    let stopline  = line('w0')
    let stride    = -s:stride
    let flag_head = 'b'
    let flag_tail = 'be'
  endif

  let [head, tail] = a:is_inc ? ['head_inclusive', 'tail_inclusive']
        \                     : ['head', 'tail']

  let search_order = [
        \   [a:lists[0], flag_head, head, 0],
        \   [a:lists[1], flag_tail, tail, a:mode ==# 'i' ? 1 : 0],
        \ ]

  " start stopwatch
  if a:opt.timeout > 0 && has('reltime') && has('float')
    let zerotime = reltime()
  endif
  let is_timedout = 0

  " searching
  for [pattern_list, flag, side, is_i_tail] in search_order
    let remain = map(copy(pattern_list), '[0, cur_pos]')
    while 1
      if pattern_list == []
        break
      endif

      let idx = 0
      for pattern in pattern_list
        let n = remain[idx][0]
        call setpos('.', remain[idx][1])
        while n < a:count
          let pos = searchpos(pattern, flag, stopline)
          if pos == s:null_pos
            break
          endif

          if is_i_tail
            let pos[1] += 1
            if pos == cur_pos[1:2]
              continue
            endif
          endif

          let candidates += [[pos, pattern, side]]
          if !(a:opt.highlight || a:opt.debug_mode)
            let n += 1
          endif
        endwhile
        let remain[idx][0] = n
        let remain[idx][1] = getpos('.')
        let idx += 1
      endfor

      " timeout
      if a:opt.timeout > 0 && has('reltime') && has('float')
        let erapsed = floor(str2float(reltimestr(reltime(zerotime)))*1000)
        if erapsed > a:opt.timeout
          let is_timedout = 1
          echo 'Patternjump: timed out.'
          break
        endif
      endif

      if len(candidates) >= a:count
        if a:direction ==# 'forward'
          let searchend = max(map(copy(candidates), 'v:val[0][0]'))
        elseif a:direction ==# 'backward'
          let searchend = min(map(copy(candidates), 'v:val[0][0]'))
        endif
        break
      elseif stopline == searchend
        break
      else
        let stopline += stride
        if a:direction ==# 'forward' && stopline > searchend
          let stopline = searchend
        elseif a:direction ==# 'backward' && stopline < 1
          let stopline = searchend
        endif
      endif
    endwhile
    if is_timedout | break | endif
  endfor
  return candidates
endfunction
"}}}
function! s:user_conf(name, arg, default) abort "{{{
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
function! s:check_raw(arg) abort "{{{
  if has_key(a:arg, 'raw')
    return a:arg['raw']
  endif

  return 0
endfunction
"}}}
function! s:resolve_pattern_dictionary(direction, mode, patternjump_patterns) abort "{{{
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
        let include_list += s:uniq_by(filter(copy(a:patternjump_patterns[matched_key].include), 'v:val != matched_key'), 'v:val')
      endif
    endif
  else
    let include_list = ['_']
  endif

  " always include '*' key if it exists
  if has_key(a:patternjump_patterns, '*')
    let include_list += ['*']
  endif

  let head_pattern_list = []
  let tail_pattern_list = []
  let head_inclusive_pattern_list = []
  let tail_inclusive_pattern_list = []
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
      let head_pattern_list += pattern_info
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
            let head_pattern_list += pattern_info.common
          elseif type(pattern_info.common) == s:type_dict
            if has_key(pattern_info.common, 'head')
              if type(pattern_info.common.head) == s:type_list
                let head_pattern_list += pattern_info.common.head
              endif
            endif

            if has_key(pattern_info.common, 'tail')
              if type(pattern_info.common.tail) == s:type_list
                let tail_pattern_list += pattern_info.common.tail
              endif
            endif

            " only in operator-pending mode (code for inclusive motion)
            if a:mode ==# 'o'
              if has_key(pattern_info.common, 'head_inclusive')
                if type(pattern_info.common.head_inclusive) == s:type_list
                  let head_inclusive_pattern_list += pattern_info.common.head_inclusive
                endif
              endif

              if has_key(pattern_info.common, 'tail_inclusive')
                if type(pattern_info.common.tail_inclusive) == s:type_list
                  let tail_inclusive_pattern_list += pattern_info.common.tail_inclusive
                endif
              endif
            endif
          endif
        endif

        if direction
          if type(pattern_info[a:direction]) == s:type_list
            let head_pattern_list += pattern_info[a:direction]
          elseif type(pattern_info[a:direction]) == s:type_dict
            if has_key(pattern_info[a:direction], 'head')
              if type(pattern_info[a:direction].head) == s:type_list
                let head_pattern_list += pattern_info[a:direction].head
              endif
            endif

            if has_key(pattern_info[a:direction], 'tail')
              if type(pattern_info[a:direction].tail) == s:type_list
                let tail_pattern_list += pattern_info[a:direction].tail
              endif
            endif

            " only in operator-pending mode (code for inclusive motion)
            if a:mode ==# 'o'
              if has_key(pattern_info[a:direction], 'head_inclusive')
                if type(pattern_info[a:direction].head_inclusive) == s:type_list
                  let head_inclusive_pattern_list += pattern_info[a:direction].head_inclusive
                endif
              endif

              if has_key(pattern_info[a:direction], 'tail_inclusive')
                if type(pattern_info[a:direction].tail_inclusive) == s:type_list
                  let tail_inclusive_pattern_list += pattern_info[a:direction].tail_inclusive
                endif
              endif
            endif
          endif
        endif
      elseif head || tail || head_inclusive || tail_inclusive
        if head
          if type(pattern_info.head) == s:type_list
            let head_pattern_list += pattern_info.head
          endif
        endif

        if tail
          if type(pattern_info.tail) == s:type_list
            let tail_pattern_list += pattern_info.tail
          endif
        endif

        " only in operator-pending mode (code for inclusive motion)
        if a:mode ==# 'o'
          if head_inclusive
            if type(pattern_info.head_inclusive) == s:type_list
              let head_inclusive_pattern_list += pattern_info.head_inclusive
            endif
          endif

          if tail_inclusive
            if type(pattern_info.tail_inclusive) == s:type_list
              let tail_inclusive_pattern_list += pattern_info.tail_inclusive
            endif
          endif
        endif
      endif
    endif

    unlet pattern_info
  endfor

  return [[head_pattern_list, tail_pattern_list], [head_inclusive_pattern_list, tail_inclusive_pattern_list]]
endfunction
"}}}
function! s:elect(direction, count, candidates) abort "{{{
  let dest = copy(s:null_candidate)
  if a:candidates != []
    let candidates_uniq = sort(s:uniq_by(copy(a:candidates), 'v:val[0]'), 's:compare')
    if a:direction ==# 'backward'
      let candidates_uniq = reverse(candidates_uniq)
    endif
    let dest = get(candidates_uniq, a:count-1, candidates_uniq[-1])
  endif
  return dest
endfunction
"}}}
function! s:init_storage() abort  "{{{
  let b:patternjump = {'cache': {}, 'highlight': {'state': 0, 'pos': []}}
endfunction
"}}}
function! s:compare(i1, i2) abort "{{{
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
function! s:uniq_by(list, f) abort "{{{
  " Note: Borrowed from vital.vim. Thanks!
  let list = map(copy(a:list), printf('[v:val, %s]', a:f))
  let i = 0
  let seen = {}
  while i < len(list)
    let key = string(list[i][1])
    if has_key(seen, key)
      call remove(list, i)
    else
      let seen[key] = 1
      let i += 1
    endif
  endwhile
  return map(list, 'v:val[0]')
endfunction
"}}}

" highliting
function! s:highlighter(candidates, opt) abort "{{{
  if !exists('b:patternjump')
    call s:init_storage()
  endif

  if a:candidates != []
    let highlightable = s:get_hilightable_line()
    let candidates    = filter(copy(a:candidates), 'match(highlightable, v:val[0][0]) > -1')
    try
      " highlighting candidates
      if b:patternjump.highlight.pos != []
        let [keep, hi_add, hi_del] = s:list_diff(candidates, b:patternjump.highlight.pos)
        let b:patternjump.highlight.pos  = keep
        let b:patternjump.highlight.pos += map(hi_add, 's:highlight_add(v:val[0])')
        let b:patternjump.highlight.pos += filter(map(hi_del, 's:highlight_del(v:val)'), 'v:val != []')
      else
        let b:patternjump.highlight.pos = map(copy(candidates), 's:highlight_add(v:val[0])')
      endif
      redraw

      " echo information
      if a:opt.debug_mode
        echomsg 'patternjump debug mode'
        for idx in range(len(candidates))
          echomsg printf('%d, %d, ''%s'', %s', candidates[idx][0][0], candidates[idx][0][1], candidates[idx][1], candidates[idx][2])
        endfor
        echomsg ''
      endif
    finally
      let b:patternjump.highlight.state = a:opt.debug_mode ? 2 : 1

      " reserving cleaner
      augroup patternjump:cleaner
        autocmd!
        autocmd CursorMoved,CursorMovedI,WinLeave <buffer> call s:cleaner()
      augroup END
    endtry
  endif
endfunction
"}}}
function! s:cleaner() abort "{{{
  if b:patternjump.highlight.state == 1
    let b:patternjump.highlight.state = 2
  else
    " delete highlighting
    call filter(map(b:patternjump.highlight.pos, 's:highlight_del(v:val)'), 'v:val != []')
    redraw

    if b:patternjump.highlight.pos == []
      let b:patternjump.highlight.state = 0

      augroup patternjump:cleaner
        autocmd!
      augroup END
    endif
  endif
endfunction
"}}}
function! s:highlight_add(pos) abort "{{{
  let pattern   = '\%' . a:pos[0] . 'l\%' . a:pos[1] . 'c.'
  let id = matchadd('IncSearch', pattern)
  return [a:pos, id]
endfunction
"}}}
function! s:highlight_del(pos) abort "{{{
  let result = matchdelete(a:pos[1])

  let output = (result == 0) ? [] : a:pos
  return output
endfunction
"}}}
function! s:list_diff(a, b) abort "{{{
  " return a list
  " [elem in a but not in b, elem in both a and b, elem not in a but in b]
  let a = map(copy(a:a), 'string(v:val[0])')
  let b = map(copy(a:b), 'string(v:val[0])')
  let a_escaped = map(copy(a), 'escape(v:val, "[]")')
  let b_escaped = map(copy(b), 'escape(v:val, "[]")')

  let is_in_b = map(range(len(a:a)), 'match(b, a_escaped[v:val]) > -1')
  let is_in_a = map(range(len(a:b)), 'match(a, b_escaped[v:val]) > -1')
  let common = map(range(len(a:b)), 'is_in_a[v:val] ? a:b[v:val] : []')
  let only_a = map(range(len(a:a)), 'is_in_b[v:val] ? [] : a:a[v:val]')
  let only_b = map(range(len(a:b)), 'is_in_a[v:val] ? [] : a:b[v:val]')
  call filter(common, 'v:val != []')
  call filter(only_a, 'v:val != []')
  call filter(only_b, 'v:val != []')
  return [common, only_a, only_b]
endfunction
"}}}
function! s:get_hilightable_line() abort "{{{
  let lines = []
  let range = range(line('w0'), line('w$'))
  let end   = line('w$')
  let idx   = 0
  let lnum  = 0
  while lnum < end
    let lnum = range[idx]
    let closedend = foldclosedend(lnum)
    if closedend < 1
      let lines += [lnum]
    else
      let idx += closedend - lnum
    endif
    let idx += 1
  endwhile
  return lines
endfunction
"}}}

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set foldmethod=marker:
" vim:set commentstring="%s:
