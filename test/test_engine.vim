" vim:set foldmethod=marker:
" vim:set commentstring="%s:
" Last Change: 31-Mar-2014.

" なぜnormal!ではなくマクロを使ったのかというとそっちの方がちらちらして好きだ
" からです！
"
" バグ多過ぎやばい
"
" TODO: searchが失敗した場合に警告できるようにしてくれ
" TODO: test_infoにon/off用のプロパティを追加
" TODO: デバッグ用にもログ吐く場所があるといいなあって
" TODO: 成功条件が「等しい」だけじゃちょっと。。。
" TODO: コメント普及させようね
" TODO: result取得が融通きかない
" TODO: 部分的にabort

let g:elementary_pattern1 = {
    \ '_' : {
    \   'head'  : ['foo', 'bar', 'baz'],
    \   },
    \ }

let g:elementary_pattern1_inc = {
    \ '_' : {
    \   'nxic' : {
    \     'head'  : ['foo', 'bar', 'baz'],
    \     },
    \   'o' : {
    \     'head_inclusive'  : ['foo', 'bar', 'baz'],
    \     },
    \   },
    \ }

let g:elementary_pattern2 = {
    \ '_' : {
    \   'tail'  : ['foo', 'bar', 'baz'],
    \   },
    \ }

let g:elementary_pattern2_inc = {
    \ '_' : {
    \   'nxic' : {
    \     'tail'  : ['foo', 'bar', 'baz'],
    \     },
    \   'o' : {
    \     'tail_inclusive'  : ['foo', 'bar', 'baz'],
    \     },
    \   },
    \ }

let g:default = {
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

let g:special_pattern1 = {
    \ '_' : {
    \   'head'  : ['^'],
    \   },
    \ }

let g:special_pattern2 = {
    \ '_' : {
    \   'tail'  : ['^'],
    \   },
    \ }

let g:special_pattern3 = {
    \ '_' : {
    \   'head'  : ['$'],
    \   },
    \ }

let g:special_pattern4 = {
    \ '_' : {
    \   'tail'  : ['$'],
    \   },
    \ }

" Test information"{{{
" Test 1
let test_info         = {}

let test_info.general = {
    \   'test_script'           : 'test_field',
    \   'commentstring'         : '^\s*" ',
    \   'caption_test'          : 'Test',
    \   'caption_result'        : 'Result',
    \   'caption_expectation'   : 'Expectation',
    \   'minimum_caption_width' : 20,
    \   'split_command'         : 'vert new',
    \   }

let test_info.pre     = {
    \   'text'     : '*** The result ***',
    \   'commands' : [],
    \   'breaking' : 0,
    \   }

let test_info.1 = {
      \ "pre" : { 'breaking' : 2, 'commands' : ['PatternjumpCachingOff',
      \                                         'let g:patternjump_wrap_line = 0',
      \                                         'let g:patternjump_ignore_case = 0',
      \                                         'let g:patternjump_highlight = 0',
      \                                         'let g:patternjump_debug_mode = 0',
      \                                         ]
      \         },
      \
      \ "1"   : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '3',
      \           'key_input'   : "\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "2"   : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '7',
      \           'key_input'   : "\<M-l>\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "3"   : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '11',
      \           'key_input'   : "\<M-l>\<M-l>\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "4"   : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '5',
      \           'key_input'   : "\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "5"   : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '9',
      \           'key_input'   : "\<M-l>\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "6"   : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '9',
      \           'key_input'   : "\<M-l>\<M-l>\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "7"   : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '7',
      \           'key_input'   : "2\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "8"   : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '11',
      \           'key_input'   : "3\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "9"   : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '11',
      \           'key_input'   : "4\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "10"  : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '2',
      \           'key_input'   : "i\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "11"  : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '6',
      \           'key_input'   : "i\<M-l>\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "12"  : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '10',
      \           'key_input'   : "i\<M-l>\<M-l>\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "13"  : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '4',
      \           'key_input'   : "i\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "14"  : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '8',
      \           'key_input'   : "i\<M-l>\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "15"  : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '8',
      \           'key_input'   : "i\<M-l>\<M-l>\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "16"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  f',
      \           'key_input'   : "v\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "17"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo b',
      \           'key_input'   : "v\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "18"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar b',
      \           'key_input'   : "v\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "19"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo b',
      \           'key_input'   : "v2\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "20"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar b',
      \           'key_input'   : "v3\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "21"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar b',
      \           'key_input'   : "v4\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "22"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo b',
      \           'key_input'   : "v\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "23"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar b',
      \           'key_input'   : "v\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "24"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar b',
      \           'key_input'   : "v\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "25"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar b',
      \           'key_input'   : "v2\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "26"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar b',
      \           'key_input'   : "v3\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "27"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar b',
      \           'key_input'   : "v4\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "28"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo ba',
      \           'key_input'   : "7lv0\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0'
      \                                   ]},
      \           'post' : {}
      \           },
      \
      \ "29"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ba',
      \           'key_input'   : "7lv0\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "30"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar b',
      \           'key_input'   : "7lv0\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "31"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ba',
      \           'key_input'   : "7lv02\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0'
      \                                   ]},
      \           'post' : {}
      \           },
      \
      \ "32"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar b',
      \           'key_input'   : "7lv03\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "33"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar b',
      \           'key_input'   : "7lv04\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "34"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo b',
      \           'key_input'   : "6lv0\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "35"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'b',
      \           'key_input'   : "6lv0\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "36"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar b',
      \           'key_input'   : "6lv0\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "37"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'b',
      \           'key_input'   : "6lv02\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "38"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar b',
      \           'key_input'   : "6lv03\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "39"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar b',
      \           'key_input'   : "6lv04\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "40"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar',
      \           'key_input'   : "8lv0\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "41"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar',
      \           'key_input'   : "8lv0\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "42"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r b',
      \           'key_input'   : "8lv0\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "43"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar',
      \           'key_input'   : "8lv02\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "44"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r b',
      \           'key_input'   : "8lv03\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "45"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r b',
      \           'key_input'   : "8lv04\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "46"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz',
      \           'key_input'   : "$v0\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "47"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz',
      \           'key_input'   : "$v0\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "48"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'baz',
      \           'key_input'   : "$v0\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "49"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz',
      \           'key_input'   : "$v02\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "50"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'baz',
      \           'key_input'   : "$v03\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "51"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'baz',
      \           'key_input'   : "$v04\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "52"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  f',
      \           'key_input'   : "v\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "53"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo b',
      \           'key_input'   : "v\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "54"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar b',
      \           'key_input'   : "v\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "55"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo b',
      \           'key_input'   : "v2\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "56"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar b',
      \           'key_input'   : "v3\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "57"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar b',
      \           'key_input'   : "v4\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "58"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo b',
      \           'key_input'   : "v\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "59"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar b',
      \           'key_input'   : "v\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "60"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar b',
      \           'key_input'   : "v\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "61"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar b',
      \           'key_input'   : "v2\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "62"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar b',
      \           'key_input'   : "v3\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "63"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar b',
      \           'key_input'   : "v4\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "64"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o ba',
      \           'key_input'   : "7lv0\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1'
      \                                   ]},
      \           'post' : {}
      \           },
      \
      \ "65"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar b',
      \           'key_input'   : "7lv0\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "66"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar b',
      \           'key_input'   : "7lv0\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "67"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar b',
      \           'key_input'   : "7lv02\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1'
      \                                   ]},
      \           'post' : {}
      \           },
      \
      \ "68"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar b',
      \           'key_input'   : "7lv03\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "69"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar b',
      \           'key_input'   : "7lv04\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "70"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o b',
      \           'key_input'   : "6lv0\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "71"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'b',
      \           'key_input'   : "6lv0\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "72"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar b',
      \           'key_input'   : "6lv0\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "73"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'b',
      \           'key_input'   : "6lv02\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "74"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar b',
      \           'key_input'   : "6lv03\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "75"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar b',
      \           'key_input'   : "6lv04\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "76"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar',
      \           'key_input'   : "8lv0\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "77"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r',
      \           'key_input'   : "8lv0\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "78"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r b',
      \           'key_input'   : "8lv0\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "79"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r',
      \           'key_input'   : "8lv02\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "80"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r b',
      \           'key_input'   : "8lv03\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "81"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r b',
      \           'key_input'   : "8lv04\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "82"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar baz',
      \           'key_input'   : "$v0\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "83"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r baz',
      \           'key_input'   : "$v0\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "84"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'z',
      \           'key_input'   : "$v0\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "85"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r baz',
      \           'key_input'   : "$v02\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "86"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'z',
      \           'key_input'   : "$v03\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "87"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'z',
      \           'key_input'   : "$v04\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "88"  : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  ',
      \           'key_input'   : "y\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "89"  : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo ',
      \           'key_input'   : "y2\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "90"  : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar ',
      \           'key_input'   : "y3\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "91"  : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  f',
      \           'key_input'   : "y\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1_inc',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "92"  : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo b',
      \           'key_input'   : "y2\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1_inc',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "93"  : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar b',
      \           'key_input'   : "y3\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1_inc',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "94"  : { 'caption'     : 'command-line mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo abar baz',
      \           'key_input'   : ":i\<CR>foo bar baz\<Home>\<M-l>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "95"  : { 'caption'     : 'command-line mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar abaz',
      \           'key_input'   : ":i\<CR>foo bar baz\<Home>\<M-l>\<M-l>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "96"  : { 'caption'     : 'command-line mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar abaz',
      \           'key_input'   : ":i\<CR>foo bar baz\<Home>\<M-l>\<M-l>\<M-l>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "97"  : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '5',
      \           'key_input'   : "\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "98"  : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '9',
      \           'key_input'   : "\<M-l>\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "99"  : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '13',
      \           'key_input'   : "\<M-l>\<M-l>\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "100"  : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '3',
      \           'key_input'   : "\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "101"  : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '7',
      \           'key_input'   : "\<M-l>\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "102"  : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '11',
      \           'key_input'   : "\<M-l>\<M-l>\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "103" : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '9',
      \           'key_input'   : "2\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "104" : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '13',
      \           'key_input'   : "3\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "105" : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '13',
      \           'key_input'   : "4\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "106"  : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '5',
      \           'key_input'   : "i\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "107"  : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '9',
      \           'key_input'   : "i\<M-l>\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "108" : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '13',
      \           'key_input'   : "i\<M-l>\<M-l>\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "109" : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '3',
      \           'key_input'   : "i\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "110" : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '7',
      \           'key_input'   : "i\<M-l>\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "111" : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '11',
      \           'key_input'   : "i\<M-l>\<M-l>\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "112" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo',
      \           'key_input'   : "v\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "113" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar',
      \           'key_input'   : "v\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "114" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar baz',
      \           'key_input'   : "v\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "115" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar',
      \           'key_input'   : "v2\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "116" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar baz',
      \           'key_input'   : "v3\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "117" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar baz',
      \           'key_input'   : "v4\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "118" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo',
      \           'key_input'   : "v\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "119" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar',
      \           'key_input'   : "v\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "120" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz',
      \           'key_input'   : "v\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "121" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar',
      \           'key_input'   : "v2\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "122" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz',
      \           'key_input'   : "v3\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "123" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz',
      \           'key_input'   : "v4\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "124" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o ba',
      \           'key_input'   : "7lv0\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0'
      \                                   ]},
      \           'post' : {}
      \           },
      \
      \ "125" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar',
      \           'key_input'   : "7lv0\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "126" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar baz',
      \           'key_input'   : "7lv0\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "127" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar',
      \           'key_input'   : "7lv02\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0'
      \                                   ]},
      \           'post' : {}
      \           },
      \
      \ "128" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar baz',
      \           'key_input'   : "7lv03\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "129" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar baz',
      \           'key_input'   : "7lv04\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "130" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o b',
      \           'key_input'   : "6lv0\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "131" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar',
      \           'key_input'   : "6lv0\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "132" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz',
      \           'key_input'   : "6lv0\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "133" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar',
      \           'key_input'   : "6lv02\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "134" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz',
      \           'key_input'   : "6lv03\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "135" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz',
      \           'key_input'   : "6lv04\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "136" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar',
      \           'key_input'   : "8lv0\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "137" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r',
      \           'key_input'   : "8lv0\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "138" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r baz',
      \           'key_input'   : "8lv0\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "139" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r',
      \           'key_input'   : "8lv02\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "140" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r baz',
      \           'key_input'   : "8lv03\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "141" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r baz',
      \           'key_input'   : "8lv04\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "142" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar baz',
      \           'key_input'   : "$v0\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "143" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r baz',
      \           'key_input'   : "$v0\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "144" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'z',
      \           'key_input'   : "$v0\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "145" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r baz',
      \           'key_input'   : "$v02\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "146" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'z',
      \           'key_input'   : "$v03\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "147" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'z',
      \           'key_input'   : "$v04\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "148" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo',
      \           'key_input'   : "v\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "149" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar',
      \           'key_input'   : "v\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "150" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar baz',
      \           'key_input'   : "v\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "151" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar',
      \           'key_input'   : "v2\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "152" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar baz',
      \           'key_input'   : "v3\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "153" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar baz',
      \           'key_input'   : "v4\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "154" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo',
      \           'key_input'   : "v\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "155" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar',
      \           'key_input'   : "v\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "156" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz',
      \           'key_input'   : "v\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "157" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar',
      \           'key_input'   : "v2\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "158" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz',
      \           'key_input'   : "v3\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "159" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz',
      \           'key_input'   : "v4\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "160" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo ba',
      \           'key_input'   : "7lv0\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1'
      \                                   ]},
      \           'post' : {}
      \           },
      \
      \ "161" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ba',
      \           'key_input'   : "7lv0\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "162" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar',
      \           'key_input'   : "7lv0\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "163" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ba',
      \           'key_input'   : "7lv02\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1'
      \                                   ]},
      \           'post' : {}
      \           },
      \
      \ "164" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar',
      \           'key_input'   : "7lv03\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "165" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar baz',
      \           'key_input'   : "7lv04\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "166" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo b',
      \           'key_input'   : "6lv0\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "167" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'b',
      \           'key_input'   : "6lv0\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "168" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar',
      \           'key_input'   : "6lv0\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "169" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'b',
      \           'key_input'   : "6lv02\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "170" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar',
      \           'key_input'   : "6lv03\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "171" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz',
      \           'key_input'   : "6lv04\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "172" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar',
      \           'key_input'   : "8lv0\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "173" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar',
      \           'key_input'   : "8lv0\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "174" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r',
      \           'key_input'   : "8lv0\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "175" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar',
      \           'key_input'   : "8lv02\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "176" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r',
      \           'key_input'   : "8lv03\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "177" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r baz',
      \           'key_input'   : "8lv04\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "178" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz',
      \           'key_input'   : "$v0\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "179" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz',
      \           'key_input'   : "$v0\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "180" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'baz',
      \           'key_input'   : "$v0\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "181" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz',
      \           'key_input'   : "$v02\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "182" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'baz',
      \           'key_input'   : "$v03\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "183" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'baz',
      \           'key_input'   : "$v04\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "184" : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  fo',
      \           'key_input'   : "y\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "185" : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo ba',
      \           'key_input'   : "y2\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "186" : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar ba',
      \           'key_input'   : "y3\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "187" : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo',
      \           'key_input'   : "y\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2_inc',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "188" : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar',
      \           'key_input'   : "y2\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2_inc',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "189" : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar baz',
      \           'key_input'   : "y3\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2_inc',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "190" : { 'caption'     : 'command-line mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'fooa bar baz',
      \           'key_input'   : ":i\<CR>foo bar baz\<Home>\<M-l>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "191" : { 'caption'     : 'command-line mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bara baz',
      \           'key_input'   : ":i\<CR>foo bar baz\<Home>\<M-l>\<M-l>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "192" : { 'caption'     : 'command-line mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baza',
      \           'key_input'   : ":i\<CR>foo bar baz\<Home>\<M-l>\<M-l>\<M-l>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "193"    : {'caption'     : 'default pattern',
      \           'result'      : 'col(".")',
      \           'expectation' : '3',
      \           'key_input'   : "\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
      \           },
      \
      \ "194"    : {'caption'     : 'default pattern',
      \           'result'      : 'col(".")',
      \           'expectation' : '5',
      \           'key_input'   : "\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
      \           },
      \
      \ "195"    : {'caption'     : 'default pattern',
      \           'result'      : 'col(".")',
      \           'expectation' : '7',
      \           'key_input'   : "\<M-l>\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
      \           },
      \
      \ "196"    : {'caption'     : 'default pattern',
      \           'result'      : 'col(".")',
      \           'expectation' : '2',
      \           'key_input'   : "i\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
      \           },
      \
      \ "197"    : {'caption'     : 'default pattern',
      \           'result'      : 'col(".")',
      \           'expectation' : '4',
      \           'key_input'   : "ea\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
      \           },
      \
      \ "198"    : {'caption'     : 'default pattern',
      \           'result'      : 'col(".")',
      \           'expectation' : '10',
      \           'key_input'   : "ea\<M-l>\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
      \           },
      \
      \ "199"    : {'caption'     : 'default pattern',
      \           'result'      : 'col(".")',
      \           'expectation' : '10',
      \           'key_input'   : "ea\<M-l>\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
      \           },
      \
      \ "200"    : {'caption'     : 'default pattern',
      \           'result'      : 'col(".")',
      \           'expectation' : '10',
      \           'key_input'   : "ea\<M-l>\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
      \           },
      \
      \ "201"    : {'caption'     : 'default pattern',
      \           'result'      : 'col(".")',
      \           'expectation' : '5',
      \           'key_input'   : "\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
      \           },
      \
      \ "202"   : {'caption'     : 'default pattern',
      \           'result'      : 'col(".")',
      \           'expectation' : '3',
      \           'key_input'   : "i\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
      \           },
      \
      \ "203"   : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  f',
      \           'key_input'   : "v\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 0']}, 'post' : {}
      \           },
      \
      \ "204"   : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo',
      \           'key_input'   : "wv\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 0']}, 'post' : {}
      \           },
      \
      \ "205"   : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar',
      \           'key_input'   : "wv\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 0']}, 'post' : {}
      \           },
      \
      \ "206"   : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o ba',
      \           'key_input'   : "2wlv2b\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 0']}, 'post' : {}
      \           },
      \
      \ "207"   : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar',
      \           'key_input'   : "2wlv2b\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 0']}, 'post' : {}
      \           },
      \
      \ "208"   : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo b',
      \           'key_input'   : "fbv0\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 0']}, 'post' : {}
      \           },
      \
      \ "209"   : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o b',
      \           'key_input'   : "fbv0\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 0']}, 'post' : {}
      \           },
      \
      \ "210"   : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar',
      \           'key_input'   : "fbv0\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 0']}, 'post' : {}
      \           },
      \
      \ "211"   : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar',
      \           'key_input'   : "fbv0\<M-l>\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 0']}, 'post' : {}
      \           },
      \
      \ "212"   : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ba',
      \           'key_input'   : "2wlv2b\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 1']}, 'post' : {}
      \           },
      \
      \ "213"   : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar',
      \           'key_input'   : "2wlv2b\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 1']}, 'post' : {}
      \           },
      \
      \ "214"   : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo b',
      \           'key_input'   : "fbv0\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 1']}, 'post' : {}
      \           },
      \
      \ "215"   : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'b',
      \           'key_input'   : "fbv0\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 1']}, 'post' : {}
      \           },
      \
      \ "216"   : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar',
      \           'key_input'   : "fbv0\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 1']}, 'post' : {}
      \           },
      \
      \ "217"   : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz',
      \           'key_input'   : "fbv0\<M-l>\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 1']}, 'post' : {}
      \           },
      \
      \ "218"   : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo',
      \           'key_input'   : "y\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 1']}, 'post' : {}
      \           },
      \
      \ "219"   : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar',
      \           'key_input'   : "y2\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 1']}, 'post' : {}
      \           },
      \
      \ "220"   : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar baz',
      \           'key_input'   : "y3\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 1']}, 'post' : {}
      \           },
      \
      \ "221" : { 'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'fooa bar',
      \           'key_input'   : ":i\<CR>foo bar\<Home>\<M-l>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:default',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "222" : { 'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'fooa,bar',
      \           'key_input'   : ":i\<CR>foo,bar\<Home>\<M-l>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:default',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "223" : { 'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'fooa)bar',
      \           'key_input'   : ":i\<CR>foo)bar\<Home>\<M-l>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:default',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "224" : { 'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'fooa]bar',
      \           'key_input'   : ":i\<CR>foo]bar\<Home>\<M-l>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:default',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "225" : { 'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'fooa}bar',
      \           'key_input'   : ":i\<CR>foo}bar\<Home>\<M-l>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:default',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "226" : { 'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foobara',
      \           'key_input'   : ":i\<CR>foobar\<Home>\<M-l>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:default',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "227" : { 'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'fooaBar',
      \           'key_input'   : ":i\<CR>fooBar\<Home>\<M-l>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:default',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "228"  : {'caption'     : 'special pattern 1',
      \           'result'      : 'col(".")',
      \           'expectation' : '3',
      \           'key_input'   : "2l\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:special_pattern1']}, 'post' : {}
      \           },
      \
      \ "229"  : {'caption'     : 'special pattern 2',
      \           'result'      : 'col(".")',
      \           'expectation' : '3',
      \           'key_input'   : "2l\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:special_pattern2']}, 'post' : {}
      \           },
      \
      \ "230"  : {'caption'     : 'special pattern 3',
      \           'result'      : 'col(".")',
      \           'expectation' : '6',
      \           'key_input'   : "2l\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:special_pattern3']}, 'post' : {}
      \           },
      \
      \ "231"  : {'caption'     : 'special pattern 4',
      \           'result'      : 'col(".")',
      \           'expectation' : '6',
      \           'key_input'   : "2l\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:special_pattern4']}, 'post' : {}
      \           },
      \
      \ "post" : {'breaking' : 1},
      \ }

let test_info.2 = {
      \ "pre" : { 'breaking' : 2, 'commands' : ['PatternjumpCachingOff',
      \                                         'let g:patternjump_wrap_line = 0',
      \                                         'let g:patternjump_ignore_case = 0',
      \                                         'let g:patternjump_highlight = 0',
      \                                         'let g:patternjump_debug_mode = 0',
      \                                         ]
      \         },
      \
      \ "1"   : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '9',
      \           'key_input'   : "$\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "2"   : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '5',
      \           'key_input'   : "$\<M-h>\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "3"   : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '1',
      \           'key_input'   : "$\<M-h>\<M-h>\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "4"   : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '9',
      \           'key_input'   : "$\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "5"   : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '5',
      \           'key_input'   : "$\<M-h>\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "6"   : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '1',
      \           'key_input'   : "$\<M-h>\<M-h>\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "7"   : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '5',
      \           'key_input'   : "$2\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "8"   : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '1',
      \           'key_input'   : "$3\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "9"   : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '1',
      \           'key_input'   : "$4\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "10"   : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '8',
      \           'key_input'   : "A\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "11"   : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '4',
      \           'key_input'   : "A\<M-h>\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "12"  : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '1',
      \           'key_input'   : "A\<M-h>\<M-h>\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "13"  : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '8',
      \           'key_input'   : "A\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "14"  : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '4',
      \           'key_input'   : "A\<M-h>\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "15"  : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '1',
      \           'key_input'   : "A\<M-h>\<M-h>\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "16"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'baz  ',
      \           'key_input'   : "$v\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "17"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz  ',
      \           'key_input'   : "$v\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "18"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz  ',
      \           'key_input'   : "$v\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "19"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz  ',
      \           'key_input'   : "$v2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "20"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz  ',
      \           'key_input'   : "$v3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "21"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz  ',
      \           'key_input'   : "$v4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "22"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'baz',
      \           'key_input'   : "$v\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "23"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz',
      \           'key_input'   : "$v\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "24"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz',
      \           'key_input'   : "$v\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "25"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz',
      \           'key_input'   : "$v2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "26"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz',
      \           'key_input'   : "$v3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "27"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz',
      \           'key_input'   : "$v4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "28"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar b',
      \           'key_input'   : "5lv$h\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "29"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ba',
      \           'key_input'   : "5lv$h\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "30"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo ba',
      \           'key_input'   : "5lv$h\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "31"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ba',
      \           'key_input'   : "5lv$h2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0'
      \                                   ]},
      \           'post' : {}
      \           },
      \
      \ "32"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo ba',
      \           'key_input'   : "5lv$h3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "33"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo ba',
      \           'key_input'   : "5lv$h4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "34"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar b',
      \           'key_input'   : "4lv$h\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "35"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'b',
      \           'key_input'   : "4lv$h\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "36"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo b',
      \           'key_input'   : "4lv$h\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "37"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'b',
      \           'key_input'   : "4lv$h2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "38"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo b',
      \           'key_input'   : "4lv$h3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "39"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo b',
      \           'key_input'   : "4lv$h4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "40"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r b',
      \           'key_input'   : "6lv$h\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "41"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar',
      \           'key_input'   : "6lv$h\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "42"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar',
      \           'key_input'   : "6lv$h\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "43"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar',
      \           'key_input'   : "6lv$h2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "44"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar',
      \           'key_input'   : "6lv$h3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "45"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar',
      \           'key_input'   : "6lv$h4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "46"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar b',
      \           'key_input'   : "v$h\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "47"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo b',
      \           'key_input'   : "v$h\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "48"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'f',
      \           'key_input'   : "v$h\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "49"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo b',
      \           'key_input'   : "v$h2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "50"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'f',
      \           'key_input'   : "v$h3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "51"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'f',
      \           'key_input'   : "v$h4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "52"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'z  ',
      \           'key_input'   : "$v\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "53"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r baz  ',
      \           'key_input'   : "$v\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "54"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar baz  ',
      \           'key_input'   : "$v\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "55"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r baz  ',
      \           'key_input'   : "$v2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "56"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar baz  ',
      \           'key_input'   : "$v3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "57"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar baz  ',
      \           'key_input'   : "$v4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "58"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r baz',
      \           'key_input'   : "$v\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "59"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar baz',
      \           'key_input'   : "$v\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "60"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar baz',
      \           'key_input'   : "$v\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "61"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar baz',
      \           'key_input'   : "$v2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "62"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar baz',
      \           'key_input'   : "$v3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "63"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar baz',
      \           'key_input'   : "$v4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "64"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar b',
      \           'key_input'   : "5lv$h\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1'
      \                                   ]},
      \           'post' : {}
      \           },
      \
      \ "65"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o ba',
      \           'key_input'   : "5lv$h\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "66"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o ba',
      \           'key_input'   : "5lv$h\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "67"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o ba',
      \           'key_input'   : "5lv$h2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1'
      \                                   ]},
      \           'post' : {}
      \           },
      \
      \ "68"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o ba',
      \           'key_input'   : "5lv$h3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "69"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o ba',
      \           'key_input'   : "5lv$h4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "70"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar b',
      \           'key_input'   : "4lv$h\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "71"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'b',
      \           'key_input'   : "4lv$h\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "72"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o b',
      \           'key_input'   : "4lv$h\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "73"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'b',
      \           'key_input'   : "4lv$h2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "74"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o b',
      \           'key_input'   : "4lv$h3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "75"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o b',
      \           'key_input'   : "4lv$h4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "76"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r b',
      \           'key_input'   : "6lv$h\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "77"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r',
      \           'key_input'   : "6lv$h\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "78"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar',
      \           'key_input'   : "6lv$h\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "79"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r',
      \           'key_input'   : "6lv$h2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "80"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar',
      \           'key_input'   : "6lv$h3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "81"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar',
      \           'key_input'   : "6lv$h4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "82"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar b',
      \           'key_input'   : "v$h\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "83"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo b',
      \           'key_input'   : "v$h\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "84"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'f',
      \           'key_input'   : "v$h\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "85"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo b',
      \           'key_input'   : "v$h2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "86"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'f',
      \           'key_input'   : "v$h3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "87"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'f',
      \           'key_input'   : "v$h4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "88"  : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'baz ',
      \           'key_input'   : "$y\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "89"  : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz ',
      \           'key_input'   : "$y2\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "90"  : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz ',
      \           'key_input'   : "$y3\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "91"  : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'baz  ',
      \           'key_input'   : "$y\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1_inc',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "92"  : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz  ',
      \           'key_input'   : "$y2\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1_inc',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "93"  : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz  ',
      \           'key_input'   : "$y3\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1_inc',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "94"  : { 'caption'     : 'command-line mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo abar',
      \           'key_input'   : ":i\<CR>foo bar\<M-h>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "95"  : { 'caption'     : 'command-line mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'afoo bar',
      \           'key_input'   : ":i\<CR>foo bar\<M-h>\<M-h>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "96"  : { 'caption'     : 'command-line mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'afoo bar',
      \           'key_input'   : ":i\<CR>foo bar\<M-h>\<M-h>\<M-h>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "97"  : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '11',
      \           'key_input'   : "$\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "98"  : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '7',
      \           'key_input'   : "$\<M-h>\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "99"  : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '3',
      \           'key_input'   : "$\<M-h>\<M-h>\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "100"  : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '7',
      \           'key_input'   : "$\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "101"  : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '3',
      \           'key_input'   : "$\<M-h>\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "102"  : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '3',
      \           'key_input'   : "$\<M-h>\<M-h>\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "103" : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '7',
      \           'key_input'   : "$2\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "104" : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '3',
      \           'key_input'   : "$3\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "105" : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '3',
      \           'key_input'   : "$4\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "106"  : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '11',
      \           'key_input'   : "A\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "107"  : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '7',
      \           'key_input'   : "A\<M-h>\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "108" : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '3',
      \           'key_input'   : "A\<M-h>\<M-h>\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "109" : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '7',
      \           'key_input'   : "A\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "110" : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '3',
      \           'key_input'   : "A\<M-h>\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "111" : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '3',
      \           'key_input'   : "A\<M-h>\<M-h>\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "112" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'z  ',
      \           'key_input'   : "$v\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "113" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r baz  ',
      \           'key_input'   : "$v\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "114" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar baz  ',
      \           'key_input'   : "$v\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "115" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r baz  ',
      \           'key_input'   : "$v2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "116" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar baz  ',
      \           'key_input'   : "$v3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "117" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar baz  ',
      \           'key_input'   : "$v4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "118" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r baz',
      \           'key_input'   : "$v\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "119" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar baz',
      \           'key_input'   : "$v\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "120" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar baz',
      \           'key_input'   : "$v\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "121" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar baz',
      \           'key_input'   : "$v2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "122" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar baz',
      \           'key_input'   : "$v3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "123" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar baz',
      \           'key_input'   : "$v4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "124" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar baz',
      \           'key_input'   : "5lv$\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0'
      \                                   ]},
      \           'post' : {}
      \           },
      \
      \ "125" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar',
      \           'key_input'   : "5lv$\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "126" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o ba',
      \           'key_input'   : "5lv$\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "127" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar',
      \           'key_input'   : "5lv$2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0'
      \                                   ]},
      \           'post' : {}
      \           },
      \
      \ "128" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o ba',
      \           'key_input'   : "5lv$3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "129" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o ba',
      \           'key_input'   : "5lv$4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "130" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz',
      \           'key_input'   : "4lv$\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "131" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar',
      \           'key_input'   : "4lv$\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "132" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o b',
      \           'key_input'   : "4lv$\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "133" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar',
      \           'key_input'   : "4lv$2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "134" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o b',
      \           'key_input'   : "4lv$3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "135" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o b',
      \           'key_input'   : "4lv$4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "136" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r baz',
      \           'key_input'   : "6lv$\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "137" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r',
      \           'key_input'   : "6lv$\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "138" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar',
      \           'key_input'   : "6lv$\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "139" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r',
      \           'key_input'   : "6lv$2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "140" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar',
      \           'key_input'   : "6lv$3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "141" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar',
      \           'key_input'   : "6lv$4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "142" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz',
      \           'key_input'   : "v$\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "143" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar',
      \           'key_input'   : "v$\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "144" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo',
      \           'key_input'   : "v$\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "145" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar',
      \           'key_input'   : "v$2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "146" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo',
      \           'key_input'   : "v$3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "147" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo',
      \           'key_input'   : "v$4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "148" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'baz  ',
      \           'key_input'   : "$v\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "149" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz  ',
      \           'key_input'   : "$v\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "150" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz  ',
      \           'key_input'   : "$v\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "151" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz  ',
      \           'key_input'   : "$v2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "152" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz  ',
      \           'key_input'   : "$v3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "153" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz  ',
      \           'key_input'   : "$v4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "154" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'baz',
      \           'key_input'   : "$v\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "155" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz',
      \           'key_input'   : "$v\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "156" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz',
      \           'key_input'   : "$v\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "157" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz',
      \           'key_input'   : "$v2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "158" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz',
      \           'key_input'   : "$v3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "159" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz',
      \           'key_input'   : "$v4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "160" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar baz',
      \           'key_input'   : "5lv$\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1'
      \                                   ]},
      \           'post' : {}
      \           },
      \
      \ "161" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar',
      \           'key_input'   : "5lv$\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "162" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ba',
      \           'key_input'   : "5lv$\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "163" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar',
      \           'key_input'   : "5lv$2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1'
      \                                   ]},
      \           'post' : {}
      \           },
      \
      \ "164" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ba',
      \           'key_input'   : "5lv$3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "165" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo ba',
      \           'key_input'   : "5lv$4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "166" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz',
      \           'key_input'   : "4lv$\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "167" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar',
      \           'key_input'   : "4lv$\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "168" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'b',
      \           'key_input'   : "4lv$\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "169" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar',
      \           'key_input'   : "4lv$2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "170" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'b',
      \           'key_input'   : "4lv$3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "171" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo b',
      \           'key_input'   : "4lv$4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "172" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r baz',
      \           'key_input'   : "6lv$\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "173" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r',
      \           'key_input'   : "6lv$\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "174" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar',
      \           'key_input'   : "6lv$\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "175" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r',
      \           'key_input'   : "6lv$2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "176" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar',
      \           'key_input'   : "6lv$3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "177" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar',
      \           'key_input'   : "6lv$4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "178" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz',
      \           'key_input'   : "v$\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "179" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar',
      \           'key_input'   : "v$\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "180" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo',
      \           'key_input'   : "v$\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "181" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar',
      \           'key_input'   : "v$2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "182" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo',
      \           'key_input'   : "v$3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "183" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo',
      \           'key_input'   : "v$4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "184" : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'z ',
      \           'key_input'   : "$y\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "185" : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r baz ',
      \           'key_input'   : "$y2\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "186" : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar baz ',
      \           'key_input'   : "$y3\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "187" : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'z  ',
      \           'key_input'   : "$y\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2_inc',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "188" : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r baz  ',
      \           'key_input'   : "$y2\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2_inc',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "189" : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar baz  ',
      \           'key_input'   : "$y3\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2_inc',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "190" : { 'caption'     : 'command-line mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bara baz',
      \           'key_input'   : ":i\<CR>foo bar baz\<M-h>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "191" : { 'caption'     : 'command-line mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'fooa bar baz',
      \           'key_input'   : ":i\<CR>foo bar baz\<M-h>\<M-h>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "192" : { 'caption'     : 'command-line mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'fooa bar baz',
      \           'key_input'   : ":i\<CR>foo bar baz\<M-h>\<M-h>\<M-h>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "193"  : {'caption'     : 'default pattern',
      \           'result'      : 'col(".")',
      \           'expectation' : '5',
      \           'key_input'   : "$\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
      \           },
      \
      \ "194"  : {'caption'     : 'default pattern',
      \           'result'      : 'col(".")',
      \           'expectation' : '5',
      \           'key_input'   : "$\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
      \           },
      \
      \ "195"  : {'caption'     : 'default pattern',
      \           'result'      : 'col(".")',
      \           'expectation' : '3',
      \           'key_input'   : "$\<M-h>\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
      \           },
      \
      \ "196"  : {'caption'     : 'default pattern',
      \           'result'      : 'col(".")',
      \           'expectation' : '5',
      \           'key_input'   : "A\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
      \           },
      \
      \ "197"  : {'caption'     : 'default pattern',
      \           'result'      : 'col(".")',
      \           'expectation' : '4',
      \           'key_input'   : "A\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
      \           },
      \
      \ "198"  : {'caption'     : 'default pattern',
      \           'result'      : 'col(".")',
      \           'expectation' : '10',
      \           'key_input'   : "A\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
      \           },
      \
      \ "199"  : {'caption'     : 'default pattern',
      \           'result'      : 'col(".")',
      \           'expectation' : '10',
      \           'key_input'   : "A\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
      \           },
      \
      \ "200"  : {'caption'     : 'default pattern',
      \           'result'      : 'col(".")',
      \           'expectation' : '10',
      \           'key_input'   : "A\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
      \           },
      \
      \ "201"  : {'caption'     : 'default pattern',
      \           'result'      : 'col(".")',
      \           'expectation' : '5',
      \           'key_input'   : "$\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
      \           },
      \
      \ "202"  : {'caption'     : 'default pattern',
      \           'result'      : 'col(".")',
      \           'expectation' : '3',
      \           'key_input'   : "A\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
      \           },
      \
      \ "203"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar',
      \           'key_input'   : "$v\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns=g:default',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "204"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo',
      \           'key_input'   : "wv$h\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns=g:default',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "205"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'f',
      \           'key_input'   : "wv$h\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns=g:default',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "206"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'oo',
      \           'key_input'   : "wlv$h\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns=g:default',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "207"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'fo',
      \           'key_input'   : "wlv$h\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns=g:default',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "208"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz',
      \           'key_input'   : "fbv$h\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns=g:default',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "209"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar',
      \           'key_input'   : "fbv$h\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns=g:default',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "210"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o b',
      \           'key_input'   : "fbv$h\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns=g:default',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "211"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo b',
      \           'key_input'   : "fbv$h\<M-h>\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns=g:default',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "212"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'oo',
      \           'key_input'   : "wlv$h\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns=g:default',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "213"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'fo',
      \           'key_input'   : "wlv$h\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 1']}, 'post' : {}
      \           },
      \
      \ "214"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz',
      \           'key_input'   : "fbv$h\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 1']}, 'post' : {}
      \           },
      \
      \ "215"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar',
      \           'key_input'   : "fbv$h\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 1']}, 'post' : {}
      \           },
      \
      \ "216"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'b',
      \           'key_input'   : "fbv$h\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 1']}, 'post' : {}
      \           },
      \
      \ "217"   : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo b',
      \           'key_input'   : "fbv$h\<M-h>\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 1']}, 'post' : {}
      \           },
      \
      \ "218"   : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'baz  ',
      \           'key_input'   : "$y\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 1']}, 'post' : {}
      \           },
      \
      \ "219"   : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz  ',
      \           'key_input'   : "$y2\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 1']}, 'post' : {}
      \           },
      \
      \ "220"   : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz  ',
      \           'key_input'   : "$y3\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 1']}, 'post' : {}
      \           },
      \
      \ "221" : { 'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'fooa bar',
      \           'key_input'   : ":i\<CR>foo bar\<M-h>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:default',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "222" : { 'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'fooa,bar',
      \           'key_input'   : ":i\<CR>foo,bar\<M-h>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:default',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "223" : { 'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'fooa)bar',
      \           'key_input'   : ":i\<CR>foo)bar\<M-h>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:default',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "224" : { 'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'fooa]bar',
      \           'key_input'   : ":i\<CR>foo]bar\<M-h>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:default',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "225" : { 'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'fooa}bar',
      \           'key_input'   : ":i\<CR>foo}bar\<M-h>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:default',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "226" : { 'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'afoobar',
      \           'key_input'   : ":i\<CR>foobar\<M-h>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:default',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "227" : { 'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'fooaBar',
      \           'key_input'   : ":i\<CR>fooBar\<M-h>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:default',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "228"  : {'caption'     : 'special pattern 1',
      \           'result'      : 'col(".")',
      \           'expectation' : '1',
      \           'key_input'   : "2l\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:special_pattern1']}, 'post' : {}
      \           },
      \
      \ "229"  : {'caption'     : 'special pattern 2',
      \           'result'      : 'col(".")',
      \           'expectation' : '1',
      \           'key_input'   : "2l\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:special_pattern2']}, 'post' : {}
      \           },
      \
      \ "230"  : {'caption'     : 'special pattern 3',
      \           'result'      : 'col(".")',
      \           'expectation' : '3',
      \           'key_input'   : "2l\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:special_pattern3']}, 'post' : {}
      \           },
      \
      \ "231"  : {'caption'     : 'special pattern 4',
      \           'result'      : 'col(".")',
      \           'expectation' : '3',
      \           'key_input'   : "2l\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:special_pattern4']}, 'post' : {}
      \           },
      \
      \ "post" : {'breaking' : 1},
      \ }

let test_info.3 = {
      \ "pre" : { 'breaking' : 2, 'commands' : ['PatternjumpCachingOff',
      \                                         'let g:patternjump_wrap_line = 1',
      \                                         'let g:patternjump_ignore_case = 0',
      \                                         'let g:patternjump_highlight = 0',
      \                                         'let g:patternjump_debug_mode = 0',
      \                                         ]
      \         },
      \
      \ "1"   : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '3',
      \           'key_input'   : "\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "2"   : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '7',
      \           'key_input'   : "\<M-l>\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "3"   : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '11',
      \           'key_input'   : "\<M-l>\<M-l>\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "4"   : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '5',
      \           'key_input'   : "\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "5"   : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '9',
      \           'key_input'   : "\<M-l>\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "6"   : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '1',
      \           'key_input'   : "\<M-l>\<M-l>\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "7"   : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '7',
      \           'key_input'   : "2\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "8"   : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '11',
      \           'key_input'   : "3\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "9"   : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '3',
      \           'key_input'   : "4\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "10"  : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '2',
      \           'key_input'   : "i\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "11"  : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '6',
      \           'key_input'   : "i\<M-l>\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "12"  : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '10',
      \           'key_input'   : "i\<M-l>\<M-l>\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "13"  : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '4',
      \           'key_input'   : "i\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "14"  : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '8',
      \           'key_input'   : "i\<M-l>\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "15"  : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '1',
      \           'key_input'   : "i\<M-l>\<M-l>\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "16"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  f',
      \           'key_input'   : "v\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "17"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo b',
      \           'key_input'   : "v\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "18"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar b',
      \           'key_input'   : "v\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "19"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo b',
      \           'key_input'   : "v2\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "20"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar b',
      \           'key_input'   : "v3\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "21"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar baz  f',
      \           'key_input'   : "v4\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "22"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo b',
      \           'key_input'   : "v\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "23"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar b',
      \           'key_input'   : "v\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "24"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar bazf',
      \           'key_input'   : "v\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "25"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar b',
      \           'key_input'   : "v2\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "26"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar bazf',
      \           'key_input'   : "v3\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "27"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar bazfoo b',
      \           'key_input'   : "v4\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "28"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo ba',
      \           'key_input'   : "7lv0\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0'
      \                                   ]},
      \           'post' : {}
      \           },
      \
      \ "29"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ba',
      \           'key_input'   : "7lv0\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "30"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar b',
      \           'key_input'   : "7lv0\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "31"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ba',
      \           'key_input'   : "7lv02\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0'
      \                                   ]},
      \           'post' : {}
      \           },
      \
      \ "32"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar b',
      \           'key_input'   : "7lv03\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "33"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar baz  f',
      \           'key_input'   : "7lv04\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "34"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo b',
      \           'key_input'   : "6lv0\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "35"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'b',
      \           'key_input'   : "6lv0\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "36"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar b',
      \           'key_input'   : "6lv0\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "37"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'b',
      \           'key_input'   : "6lv02\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "38"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar b',
      \           'key_input'   : "6lv03\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "39"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz  f',
      \           'key_input'   : "6lv04\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "40"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar',
      \           'key_input'   : "8lv0\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "41"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar',
      \           'key_input'   : "8lv0\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "42"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r b',
      \           'key_input'   : "8lv0\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "43"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar',
      \           'key_input'   : "8lv02\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "44"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r b',
      \           'key_input'   : "8lv03\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "45"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r baz  f',
      \           'key_input'   : "8lv04\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "46"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz',
      \           'key_input'   : "$v0\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "47"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz',
      \           'key_input'   : "$v0\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "48"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'baz',
      \           'key_input'   : "$v0\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "49"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz',
      \           'key_input'   : "$v02\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "50"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'baz',
      \           'key_input'   : "$v03\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "51"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'z  f',
      \           'key_input'   : "$v04\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "52"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  f',
      \           'key_input'   : "v\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "53"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo b',
      \           'key_input'   : "v\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "54"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar b',
      \           'key_input'   : "v\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "55"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo b',
      \           'key_input'   : "v2\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "56"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar b',
      \           'key_input'   : "v3\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "57"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar baz  f',
      \           'key_input'   : "v4\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "58"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo b',
      \           'key_input'   : "v\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "59"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar b',
      \           'key_input'   : "v\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "60"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar bazf',
      \           'key_input'   : "v\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "61"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar b',
      \           'key_input'   : "v2\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "62"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar bazf',
      \           'key_input'   : "v3\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "63"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar bazfoo b',
      \           'key_input'   : "v4\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "64"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o ba',
      \           'key_input'   : "7lv0\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "65"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar b',
      \           'key_input'   : "7lv0\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "66"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar baz  f',
      \           'key_input'   : "7lv0\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "67"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar b',
      \           'key_input'   : "7lv02\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1'
      \                                   ]},
      \           'post' : {}
      \           },
      \
      \ "68"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar baz  f',
      \           'key_input'   : "7lv03\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "69"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar baz  foo b',
      \           'key_input'   : "7lv04\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "70"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o b',
      \           'key_input'   : "6lv0\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "71"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'b',
      \           'key_input'   : "6lv0\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "72"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar b',
      \           'key_input'   : "6lv0\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "73"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'b',
      \           'key_input'   : "6lv02\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "74"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar b',
      \           'key_input'   : "6lv03\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "75"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz  f',
      \           'key_input'   : "6lv04\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "76"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar',
      \           'key_input'   : "8lv0\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "77"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r',
      \           'key_input'   : "8lv0\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "78"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r b',
      \           'key_input'   : "8lv0\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "79"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r',
      \           'key_input'   : "8lv02\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "80"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r b',
      \           'key_input'   : "8lv03\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "81"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r baz  f',
      \           'key_input'   : "8lv04\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "82"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar baz',
      \           'key_input'   : "$v0\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "83"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r baz',
      \           'key_input'   : "$v0\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "84"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'z',
      \           'key_input'   : "$v0\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "85"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r baz',
      \           'key_input'   : "$v02\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "86"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'z',
      \           'key_input'   : "$v03\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "87"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'z  f',
      \           'key_input'   : "$v04\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "88"  : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  ',
      \           'key_input'   : "y\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "89"  : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo ',
      \           'key_input'   : "y2\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "90"  : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar ',
      \           'key_input'   : "y3\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "91"  : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  f',
      \           'key_input'   : "y\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1_inc',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "92"  : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo b',
      \           'key_input'   : "y2\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1_inc',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "93"  : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar b',
      \           'key_input'   : "y3\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1_inc',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "94"  : { 'caption'     : 'command-line mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo abar baz',
      \           'key_input'   : ":i\<CR>foo bar baz\<Home>\<M-l>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "95"  : { 'caption'     : 'command-line mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar abaz',
      \           'key_input'   : ":i\<CR>foo bar baz\<Home>\<M-l>\<M-l>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "96"  : { 'caption'     : 'command-line mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar abaz',
      \           'key_input'   : ":i\<CR>foo bar baz\<Home>\<M-l>\<M-l>\<M-l>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "97"  : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '5',
      \           'key_input'   : "\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "98"  : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '9',
      \           'key_input'   : "\<M-l>\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "99"  : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '13',
      \           'key_input'   : "\<M-l>\<M-l>\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "100"  : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '3',
      \           'key_input'   : "\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "101"  : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '7',
      \           'key_input'   : "\<M-l>\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "102"  : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '11',
      \           'key_input'   : "\<M-l>\<M-l>\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "103" : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '9',
      \           'key_input'   : "2\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "104" : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '13',
      \           'key_input'   : "3\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "105" : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '5',
      \           'key_input'   : "4\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "106" : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '5',
      \           'key_input'   : "i\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "107" : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '9',
      \           'key_input'   : "i\<M-l>\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "108" : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '13',
      \           'key_input'   : "i\<M-l>\<M-l>\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "109" : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '3',
      \           'key_input'   : "i\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "110" : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '7',
      \           'key_input'   : "i\<M-l>\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "111" : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '11',
      \           'key_input'   : "i\<M-l>\<M-l>\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "112" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo',
      \           'key_input'   : "v\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "113" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar',
      \           'key_input'   : "v\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "114" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar baz',
      \           'key_input'   : "v\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "115" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar',
      \           'key_input'   : "v2\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "116" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar baz',
      \           'key_input'   : "v3\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "117" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar baz  foo',
      \           'key_input'   : "v4\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "118" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo',
      \           'key_input'   : "v\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "119" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar',
      \           'key_input'   : "v\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "120" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz',
      \           'key_input'   : "v\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "121" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar',
      \           'key_input'   : "v2\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "122" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz',
      \           'key_input'   : "v3\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "123" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar bazfoo',
      \           'key_input'   : "v4\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "124" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o ba',
      \           'key_input'   : "7lv0\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0'
      \                                   ]},
      \           'post' : {}
      \           },
      \
      \ "125" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar',
      \           'key_input'   : "7lv0\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "126" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar baz',
      \           'key_input'   : "7lv0\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "127" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar',
      \           'key_input'   : "7lv02\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0'
      \                                   ]},
      \           'post' : {}
      \           },
      \
      \ "128" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar baz',
      \           'key_input'   : "7lv03\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "129" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar baz  foo',
      \           'key_input'   : "7lv04\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "130" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o b',
      \           'key_input'   : "6lv0\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "131" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar',
      \           'key_input'   : "6lv0\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "132" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz',
      \           'key_input'   : "6lv0\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "133" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar',
      \           'key_input'   : "6lv02\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "134" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz',
      \           'key_input'   : "6lv03\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "135" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz  foo',
      \           'key_input'   : "6lv04\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "136" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar',
      \           'key_input'   : "8lv0\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "137" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r',
      \           'key_input'   : "8lv0\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "138" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r baz',
      \           'key_input'   : "8lv0\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "139" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r',
      \           'key_input'   : "8lv02\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "140" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r baz',
      \           'key_input'   : "8lv03\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "141" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r baz  foo',
      \           'key_input'   : "8lv04\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "142" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar baz',
      \           'key_input'   : "$v0\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "143" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r baz',
      \           'key_input'   : "$v0\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "144" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'z',
      \           'key_input'   : "$v0\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "145" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r baz',
      \           'key_input'   : "$v02\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "146" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'z',
      \           'key_input'   : "$v03\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "147" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'z  foo',
      \           'key_input'   : "$v04\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "148" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo',
      \           'key_input'   : "v\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "149" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar',
      \           'key_input'   : "v\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "150" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar baz',
      \           'key_input'   : "v\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "151" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar',
      \           'key_input'   : "v2\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "152" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar baz',
      \           'key_input'   : "v3\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "153" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar baz  foo',
      \           'key_input'   : "v4\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "154" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo',
      \           'key_input'   : "v\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "155" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar',
      \           'key_input'   : "v\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "156" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz',
      \           'key_input'   : "v\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "157" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar',
      \           'key_input'   : "v2\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "158" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz',
      \           'key_input'   : "v3\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "159" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar bazfoo',
      \           'key_input'   : "v4\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "160" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo ba',
      \           'key_input'   : "7lv0\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1'
      \                                   ]},
      \           'post' : {}
      \           },
      \
      \ "161" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ba',
      \           'key_input'   : "7lv0\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "162" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar',
      \           'key_input'   : "7lv0\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "163" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ba',
      \           'key_input'   : "7lv02\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1'
      \                                   ]},
      \           'post' : {}
      \           },
      \
      \ "164" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar',
      \           'key_input'   : "7lv03\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "165" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar baz',
      \           'key_input'   : "7lv04\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "166" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo b',
      \           'key_input'   : "6lv0\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "167" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'b',
      \           'key_input'   : "6lv0\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "168" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar',
      \           'key_input'   : "6lv0\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "169" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'b',
      \           'key_input'   : "6lv02\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "170" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar',
      \           'key_input'   : "6lv03\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "171" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz',
      \           'key_input'   : "6lv04\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "172" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar',
      \           'key_input'   : "8lv0\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "173" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar',
      \           'key_input'   : "8lv0\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "174" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r',
      \           'key_input'   : "8lv0\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "175" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar',
      \           'key_input'   : "8lv02\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "176" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r',
      \           'key_input'   : "8lv03\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "177" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r baz',
      \           'key_input'   : "8lv04\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "178" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz',
      \           'key_input'   : "$v0\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "179" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz',
      \           'key_input'   : "$v0\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "180" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'baz',
      \           'key_input'   : "$v0\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "181" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz',
      \           'key_input'   : "$v02\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "182" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'baz',
      \           'key_input'   : "$v03\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "183" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'z',
      \           'key_input'   : "$v04\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "184" : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  fo',
      \           'key_input'   : "y\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "185" : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo ba',
      \           'key_input'   : "y2\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "186" : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar ba',
      \           'key_input'   : "y3\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "187" : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo',
      \           'key_input'   : "y\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2_inc',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "188" : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar',
      \           'key_input'   : "y2\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2_inc',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "189" : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar baz',
      \           'key_input'   : "y3\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2_inc',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "190" : { 'caption'     : 'command-line mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'fooa bar baz',
      \           'key_input'   : ":i\<CR>foo bar baz\<Home>\<M-l>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "191" : { 'caption'     : 'command-line mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bara baz',
      \           'key_input'   : ":i\<CR>foo bar baz\<Home>\<M-l>\<M-l>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "192" : { 'caption'     : 'command-line mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baza',
      \           'key_input'   : ":i\<CR>foo bar baz\<Home>\<M-l>\<M-l>\<M-l>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "193"  : {'caption'     : 'default pattern',
      \           'result'      : 'col(".")',
      \           'expectation' : '3',
      \           'key_input'   : "\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
      \           },
      \
      \ "194"  : {'caption'     : 'default pattern',
      \           'result'      : 'col(".")',
      \           'expectation' : '5',
      \           'key_input'   : "\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
      \           },
      \
      \ "195"  : {'caption'     : 'default pattern',
      \           'result'      : 'col(".")',
      \           'expectation' : '7',
      \           'key_input'   : "\<M-l>\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
      \           },
      \
      \ "196"  : {'caption'     : 'default pattern',
      \           'result'      : 'col(".")',
      \           'expectation' : '2',
      \           'key_input'   : "i\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
      \           },
      \
      \ "197"  : {'caption'     : 'default pattern',
      \           'result'      : 'col(".")',
      \           'expectation' : '4',
      \           'key_input'   : "ea\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
      \           },
      \
      \ "198"  : {'caption'     : 'default pattern',
      \           'result'      : 'col(".")',
      \           'expectation' : '10',
      \           'key_input'   : "ea\<M-l>\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
      \           },
      \
      \ "199"  : {'caption'     : 'default pattern',
      \           'result'      : 'col(".")',
      \           'expectation' : '10',
      \           'key_input'   : "ea\<M-l>\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
      \           },
      \
      \ "200"  : {'caption'     : 'default pattern',
      \           'result'      : 'col(".")',
      \           'expectation' : '10',
      \           'key_input'   : "ea\<M-l>\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
      \           },
      \
      \ "201"  : {'caption'     : 'default pattern',
      \           'result'      : 'col(".")',
      \           'expectation' : '5',
      \           'key_input'   : "\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
      \           },
      \
      \ "202"  : {'caption'     : 'default pattern',
      \           'result'      : 'col(".")',
      \           'expectation' : '3',
      \           'key_input'   : "i\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
      \           },
      \
      \ "203"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  f',
      \           'key_input'   : "v\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 0']}, 'post' : {}
      \           },
      \
      \ "204"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo',
      \           'key_input'   : "wv\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 0']}, 'post' : {}
      \           },
      \
      \ "205"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar',
      \           'key_input'   : "wv\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 0']}, 'post' : {}
      \           },
      \
      \ "206"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o ba',
      \           'key_input'   : "2wlv2b\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 0']}, 'post' : {}
      \           },
      \
      \ "207"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar',
      \           'key_input'   : "2wlv2b\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 0']}, 'post' : {}
      \           },
      \
      \ "208"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo b',
      \           'key_input'   : "fbv0\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 0']}, 'post' : {}
      \           },
      \
      \ "209"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o b',
      \           'key_input'   : "fbv0\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 0']}, 'post' : {}
      \           },
      \
      \ "210"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar',
      \           'key_input'   : "fbv0\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 0']}, 'post' : {}
      \           },
      \
      \ "211"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar  f',
      \           'key_input'   : "fbv0\<M-l>\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 0']}, 'post' : {}
      \           },
      \
      \ "212"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ba',
      \           'key_input'   : "2wlv2b\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 1']}, 'post' : {}
      \           },
      \
      \ "213"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar',
      \           'key_input'   : "2wlv2b\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 1']}, 'post' : {}
      \           },
      \
      \ "214"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo b',
      \           'key_input'   : "fbv0\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 1']}, 'post' : {}
      \           },
      \
      \ "215"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'b',
      \           'key_input'   : "fbv0\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 1']}, 'post' : {}
      \           },
      \
      \ "216"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar',
      \           'key_input'   : "fbv0\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 1']}, 'post' : {}
      \           },
      \
      \ "217"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz',
      \           'key_input'   : "fbv0\<M-l>\<M-l>\<M-l>\<M-l>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 1']}, 'post' : {}
      \           },
      \
      \ "218"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo',
      \           'key_input'   : "y\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 1']}, 'post' : {}
      \           },
      \
      \ "219"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar',
      \           'key_input'   : "y2\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 1']}, 'post' : {}
      \           },
      \
      \ "220"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : '  foo bar baz',
      \           'key_input'   : "y3\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 1']}, 'post' : {}
      \           },
      \
      \ "221" : { 'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'fooa bar',
      \           'key_input'   : ":i\<CR>foo bar\<Home>\<M-l>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:default',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "222" : { 'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'fooa,bar',
      \           'key_input'   : ":i\<CR>foo,bar\<Home>\<M-l>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:default',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "223" : { 'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'fooa)bar',
      \           'key_input'   : ":i\<CR>foo)bar\<Home>\<M-l>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:default',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "224" : { 'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'fooa]bar',
      \           'key_input'   : ":i\<CR>foo]bar\<Home>\<M-l>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:default',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "225" : { 'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'fooa}bar',
      \           'key_input'   : ":i\<CR>foo}bar\<Home>\<M-l>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:default',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "226" : { 'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foobara',
      \           'key_input'   : ":i\<CR>foobar\<Home>\<M-l>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:default',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "227" : { 'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'fooaBar',
      \           'key_input'   : ":i\<CR>fooBar\<Home>\<M-l>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:default',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "228"  : {'caption'     : 'special pattern 1',
      \           'result'      : 'col(".")',
      \           'expectation' : '1',
      \           'key_input'   : "2l\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:special_pattern1']}, 'post' : {}
      \           },
      \
      \ "229"  : {'caption'     : 'special pattern 2',
      \           'result'      : 'col(".")',
      \           'expectation' : '1',
      \           'key_input'   : "2l\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:special_pattern2']}, 'post' : {}
      \           },
      \
      \ "230"  : {'caption'     : 'special pattern 3',
      \           'result'      : 'col(".")',
      \           'expectation' : '6',
      \           'key_input'   : "2l\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:special_pattern3']}, 'post' : {}
      \           },
      \
      \ "231"  : {'caption'     : 'special pattern 4',
      \           'result'      : 'col(".")',
      \           'expectation' : '6',
      \           'key_input'   : "2l\<M-l>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:special_pattern4']}, 'post' : {}
      \           },
      \
      \ "post" : {'breaking' : 1},
      \ }

let test_info.4 = {
      \ "pre" : { 'breaking' : 2, 'commands' : ['PatternjumpCachingOff',
      \                                         'let g:patternjump_wrap_line = 1',
      \                                         'let g:patternjump_ignore_case = 0',
      \                                         'let g:patternjump_highlight = 0',
      \                                         'let g:patternjump_debug_mode = 0',
      \                                         ]
      \         },
      \
      \ "1"   : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '9',
      \           'key_input'   : "j$\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "2"   : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '5',
      \           'key_input'   : "j$\<M-h>\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "3"   : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '1',
      \           'key_input'   : "j$\<M-h>\<M-h>\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "4"   : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '9',
      \           'key_input'   : "j$\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "5"   : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '5',
      \           'key_input'   : "j$\<M-h>\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "6"   : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '1',
      \           'key_input'   : "j$\<M-h>\<M-h>\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "7"   : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '5',
      \           'key_input'   : "j$2\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "8"   : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '1',
      \           'key_input'   : "j$3\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "9"   : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '9',
      \           'key_input'   : "j$4\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "10"   : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '8',
      \           'key_input'   : "jA\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "11"   : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '4',
      \           'key_input'   : "jA\<M-h>\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "12"  : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '1',
      \           'key_input'   : "jA\<M-h>\<M-h>\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "13"  : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '8',
      \           'key_input'   : "jA\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "14"  : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '4',
      \           'key_input'   : "jA\<M-h>\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "15"  : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '1',
      \           'key_input'   : "jA\<M-h>\<M-h>\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1']},
      \           'post' : {}
      \           },
      \
      \ "16"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'baz  ',
      \           'key_input'   : "j$v\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "17"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz  ',
      \           'key_input'   : "j$v\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "18"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz  ',
      \           'key_input'   : "j$v\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "19"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz  ',
      \           'key_input'   : "j$v2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "20"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz  ',
      \           'key_input'   : "j$v3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "21"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'baz  foo bar baz  ',
      \           'key_input'   : "j$v4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "22"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'baz',
      \           'key_input'   : "j$v\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "23"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz',
      \           'key_input'   : "j$v\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "24"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz',
      \           'key_input'   : "j$v\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "25"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz',
      \           'key_input'   : "j$v2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "26"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz',
      \           'key_input'   : "j$v3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "27"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bazfoo bar baz',
      \           'key_input'   : "j$v4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "28"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar b',
      \           'key_input'   : "j5lv$h\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "29"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ba',
      \           'key_input'   : "j5lv$h\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "30"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo ba',
      \           'key_input'   : "j5lv$h\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "31"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ba',
      \           'key_input'   : "j5lv$h2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0'
      \                                   ]},
      \           'post' : {}
      \           },
      \
      \ "32"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo ba',
      \           'key_input'   : "j5lv$h3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "33"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'baz  foo ba',
      \           'key_input'   : "j5lv$h4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "34"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar b',
      \           'key_input'   : "j4lv$h\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "35"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'b',
      \           'key_input'   : "j4lv$h\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "36"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo b',
      \           'key_input'   : "j4lv$h\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "37"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'b',
      \           'key_input'   : "j4lv$h2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "38"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo b',
      \           'key_input'   : "j4lv$h3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "39"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'baz  foo b',
      \           'key_input'   : "j4lv$h4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "40"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r b',
      \           'key_input'   : "j6lv$h\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "41"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar',
      \           'key_input'   : "j6lv$h\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "42"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar',
      \           'key_input'   : "j6lv$h\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "43"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar',
      \           'key_input'   : "j6lv$h2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "44"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar',
      \           'key_input'   : "j6lv$h3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "45"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'baz  foo bar',
      \           'key_input'   : "j6lv$h4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "46"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar b',
      \           'key_input'   : "jv$h\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "47"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo b',
      \           'key_input'   : "jv$h\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "48"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'f',
      \           'key_input'   : "jv$h\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "49"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo b',
      \           'key_input'   : "jv$h2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "50"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'f',
      \           'key_input'   : "jv$h3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "51"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'baz  f',
      \           'key_input'   : "jv$h4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "52"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'z  ',
      \           'key_input'   : "j$v\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "53"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r baz  ',
      \           'key_input'   : "j$v\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "54"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar baz  ',
      \           'key_input'   : "j$v\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "55"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r baz  ',
      \           'key_input'   : "j$v2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "56"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar baz  ',
      \           'key_input'   : "j$v3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "57"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'z  foo bar baz  ',
      \           'key_input'   : "j$v4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "58"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r baz',
      \           'key_input'   : "j$v\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "59"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar baz',
      \           'key_input'   : "j$v\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "60"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'zfoo bar baz',
      \           'key_input'   : "j$v\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "61"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar baz',
      \           'key_input'   : "j$v2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "62"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'zfoo bar baz',
      \           'key_input'   : "j$v3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "63"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r bazfoo bar baz',
      \           'key_input'   : "j$v4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "64"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar b',
      \           'key_input'   : "j5lv$h\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1'
      \                                   ]},
      \           'post' : {}
      \           },
      \
      \ "65"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o ba',
      \           'key_input'   : "j5lv$h\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "66"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'z  foo ba',
      \           'key_input'   : "j5lv$h\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "67"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o ba',
      \           'key_input'   : "j5lv$h2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1'
      \                                   ]},
      \           'post' : {}
      \           },
      \
      \ "68"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'z  foo ba',
      \           'key_input'   : "j5lv$h3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "69"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r baz  foo ba',
      \           'key_input'   : "j5lv$h4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "70"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar b',
      \           'key_input'   : "j4lv$h\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "71"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'b',
      \           'key_input'   : "j4lv$h\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "72"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o b',
      \           'key_input'   : "j4lv$h\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "73"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'b',
      \           'key_input'   : "j4lv$h2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "74"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o b',
      \           'key_input'   : "j4lv$h3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "75"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'z  foo b',
      \           'key_input'   : "j4lv$h4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "76"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r b',
      \           'key_input'   : "j6lv$h\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "77"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r',
      \           'key_input'   : "j6lv$h\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "78"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar',
      \           'key_input'   : "j6lv$h\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "79"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r',
      \           'key_input'   : "j6lv$h2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "80"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar',
      \           'key_input'   : "j6lv$h3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "81"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'z  foo bar',
      \           'key_input'   : "j6lv$h4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "82"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar b',
      \           'key_input'   : "v$h\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "83"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo b',
      \           'key_input'   : "jv$h\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "84"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'f',
      \           'key_input'   : "jv$h\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "85"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo b',
      \           'key_input'   : "jv$h2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "86"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'f',
      \           'key_input'   : "jv$h3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "87"  : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'z  f',
      \           'key_input'   : "jv$h4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "88"  : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'baz ',
      \           'key_input'   : "j$y\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "89"  : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz ',
      \           'key_input'   : "j$y2\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "90"  : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz ',
      \           'key_input'   : "j$y3\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "91"  : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'baz  ',
      \           'key_input'   : "j$y\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1_inc',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "92"  : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz  ',
      \           'key_input'   : "j$y2\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1_inc',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "93"  : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz  ',
      \           'key_input'   : "j$y3\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1_inc',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "94"  : { 'caption'     : 'command-line mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo abar',
      \           'key_input'   : ":i\<CR>foo bar\<M-h>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "95"  : { 'caption'     : 'command-line mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'afoo bar',
      \           'key_input'   : ":i\<CR>foo bar\<M-h>\<M-h>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "96"  : { 'caption'     : 'command-line mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'afoo bar',
      \           'key_input'   : ":i\<CR>foo bar\<M-h>\<M-h>\<M-h>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern1',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "97"  : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '11',
      \           'key_input'   : "j$\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "98"  : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '7',
      \           'key_input'   : "j$\<M-h>\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "99"  : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '3',
      \           'key_input'   : "j$\<M-h>\<M-h>\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "100"  : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '7',
      \           'key_input'   : "j$\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "101"  : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '3',
      \           'key_input'   : "j$\<M-h>\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "102"  : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '11',
      \           'key_input'   : "j$\<M-h>\<M-h>\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "103" : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '7',
      \           'key_input'   : "j$2\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "104" : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '3',
      \           'key_input'   : "j$3\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "105" : { 'caption'     : 'normal mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '11',
      \           'key_input'   : "j$4\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "106"  : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '11',
      \           'key_input'   : "jA\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "107"  : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '7',
      \           'key_input'   : "jA\<M-h>\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "108" : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '3',
      \           'key_input'   : "jA\<M-h>\<M-h>\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "109" : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '7',
      \           'key_input'   : "jA\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "110" : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '3',
      \           'key_input'   : "jA\<M-h>\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "111" : { 'caption'     : 'insert mode',
      \           'result'      : 'col(".")',
      \           'expectation' : '11',
      \           'key_input'   : "jA\<M-h>\<M-h>\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2']},
      \           'post' : {}
      \           },
      \
      \ "112" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'z  ',
      \           'key_input'   : "j$v\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "113" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r baz  ',
      \           'key_input'   : "j$v\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "114" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar baz  ',
      \           'key_input'   : "j$v\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "115" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r baz  ',
      \           'key_input'   : "j$v2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "116" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar baz  ',
      \           'key_input'   : "j$v3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "117" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'z  foo bar baz  ',
      \           'key_input'   : "j$v4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "118" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r baz',
      \           'key_input'   : "j$v\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "119" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar baz',
      \           'key_input'   : "j$v\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "120" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'zfoo bar baz',
      \           'key_input'   : "j$v\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "121" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar baz',
      \           'key_input'   : "j$v2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "122" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'zfoo bar baz',
      \           'key_input'   : "j$v3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "123" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r bazfoo bar baz',
      \           'key_input'   : "j$v4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "124" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar baz',
      \           'key_input'   : "j5lv$\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0'
      \                                   ]},
      \           'post' : {}
      \           },
      \
      \ "125" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar',
      \           'key_input'   : "j5lv$\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "126" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o ba',
      \           'key_input'   : "j5lv$\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "127" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar',
      \           'key_input'   : "j5lv$2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0'
      \                                   ]},
      \           'post' : {}
      \           },
      \
      \ "128" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o ba',
      \           'key_input'   : "j5lv$3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "129" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'z  foo ba',
      \           'key_input'   : "j5lv$4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "130" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz',
      \           'key_input'   : "j4lv$\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "131" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar',
      \           'key_input'   : "j4lv$\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "132" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o b',
      \           'key_input'   : "j4lv$\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "133" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar',
      \           'key_input'   : "j4lv$2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "134" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o b',
      \           'key_input'   : "j4lv$3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "135" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'z  foo b',
      \           'key_input'   : "j4lv$4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "136" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r baz',
      \           'key_input'   : "j6lv$\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "137" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r',
      \           'key_input'   : "j6lv$\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "138" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar',
      \           'key_input'   : "j6lv$\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "139" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r',
      \           'key_input'   : "j6lv$2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "140" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar',
      \           'key_input'   : "j6lv$3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "141" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'z  foo bar',
      \           'key_input'   : "j6lv$4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "142" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz',
      \           'key_input'   : "jv$\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "143" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar',
      \           'key_input'   : "jv$\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "144" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo',
      \           'key_input'   : "jv$\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "145" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar',
      \           'key_input'   : "jv$2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "146" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo',
      \           'key_input'   : "jv$3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "147" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'z  f',
      \           'key_input'   : "jv$4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "148" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'baz  ',
      \           'key_input'   : "j$v\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "149" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz  ',
      \           'key_input'   : "j$v\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "150" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz  ',
      \           'key_input'   : "j$v\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "151" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz  ',
      \           'key_input'   : "j$v2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "152" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz  ',
      \           'key_input'   : "j$v3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "153" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'baz  foo bar baz  ',
      \           'key_input'   : "j$v4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "154" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'baz',
      \           'key_input'   : "j$v\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "155" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz',
      \           'key_input'   : "j$v\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "156" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz',
      \           'key_input'   : "j$v\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "157" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz',
      \           'key_input'   : "j$v2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "158" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz',
      \           'key_input'   : "j$v3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "159" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bazfoo bar baz',
      \           'key_input'   : "j$v4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "160" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar baz',
      \           'key_input'   : "j5lv$\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1'
      \                                   ]},
      \           'post' : {}
      \           },
      \
      \ "161" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar',
      \           'key_input'   : "j5lv$\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "162" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ba',
      \           'key_input'   : "j5lv$\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "163" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ar',
      \           'key_input'   : "j5lv$2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1'
      \                                   ]},
      \           'post' : {}
      \           },
      \
      \ "164" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'ba',
      \           'key_input'   : "j5lv$3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "165" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo ba',
      \           'key_input'   : "j5lv$4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "166" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz',
      \           'key_input'   : "j4lv$\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "167" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar',
      \           'key_input'   : "j4lv$\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "168" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'b',
      \           'key_input'   : "j4lv$\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "169" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar',
      \           'key_input'   : "j4lv$2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "170" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'b',
      \           'key_input'   : "j4lv$3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "171" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo b',
      \           'key_input'   : "j4lv$4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "172" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r baz',
      \           'key_input'   : "j6lv$\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "173" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r',
      \           'key_input'   : "j6lv$\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "174" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar',
      \           'key_input'   : "j6lv$\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "175" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r',
      \           'key_input'   : "j6lv$2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "176" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar',
      \           'key_input'   : "j6lv$3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "177" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar',
      \           'key_input'   : "j6lv$4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "178" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz',
      \           'key_input'   : "jv$\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "179" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar',
      \           'key_input'   : "jv$\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "180" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo',
      \           'key_input'   : "jv$\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "181" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar',
      \           'key_input'   : "jv$2\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "182" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo',
      \           'key_input'   : "jv$3\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "183" : { 'caption'     : 'visual mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'f',
      \           'key_input'   : "jv$4\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "184" : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'z ',
      \           'key_input'   : "j$y\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "185" : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r baz ',
      \           'key_input'   : "j$y2\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "186" : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar baz ',
      \           'key_input'   : "j$y3\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "187" : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'z  ',
      \           'key_input'   : "j$y\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2_inc',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "188" : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'r baz  ',
      \           'key_input'   : "j$y2\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2_inc',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "189" : { 'caption'     : 'operator-pending mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar baz  ',
      \           'key_input'   : "j$y3\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2_inc',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "190" : { 'caption'     : 'command-line mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bara baz',
      \           'key_input'   : ":i\<CR>foo bar baz\<M-h>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "191" : { 'caption'     : 'command-line mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'fooa bar baz',
      \           'key_input'   : ":i\<CR>foo bar baz\<M-h>\<M-h>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "192" : { 'caption'     : 'command-line mode',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'fooa bar baz',
      \           'key_input'   : ":i\<CR>foo bar baz\<M-h>\<M-h>\<M-h>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:elementary_pattern2',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "193"  : {'caption'     : 'default pattern',
      \           'result'      : 'col(".")',
      \           'expectation' : '5',
      \           'key_input'   : "$\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
      \           },
      \
      \ "194"  : {'caption'     : 'default pattern',
      \           'result'      : 'col(".")',
      \           'expectation' : '5',
      \           'key_input'   : "$\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
      \           },
      \
      \ "195"  : {'caption'     : 'default pattern',
      \           'result'      : 'col(".")',
      \           'expectation' : '3',
      \           'key_input'   : "j$\<M-h>\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
      \           },
      \
      \ "196"  : {'caption'     : 'default pattern',
      \           'result'      : 'col(".")',
      \           'expectation' : '5',
      \           'key_input'   : "jA\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
      \           },
      \
      \ "197"  : {'caption'     : 'default pattern',
      \           'result'      : 'col(".")',
      \           'expectation' : '4',
      \           'key_input'   : "A\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
      \           },
      \
      \ "198"  : {'caption'     : 'default pattern',
      \           'result'      : 'col(".")',
      \           'expectation' : '10',
      \           'key_input'   : "A\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
      \           },
      \
      \ "199"  : {'caption'     : 'default pattern',
      \           'result'      : 'col(".")',
      \           'expectation' : '10',
      \           'key_input'   : "A\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
      \           },
      \
      \ "200"  : {'caption'     : 'default pattern',
      \           'result'      : 'col(".")',
      \           'expectation' : '10',
      \           'key_input'   : "A\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
      \           },
      \
      \ "201"  : {'caption'     : 'default pattern',
      \           'result'      : 'col(".")',
      \           'expectation' : '5',
      \           'key_input'   : "$\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
      \           },
      \
      \ "202"  : {'caption'     : 'default pattern',
      \           'result'      : 'col(".")',
      \           'expectation' : '3',
      \           'key_input'   : "A\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
      \           },
      \
      \ "203"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar',
      \           'key_input'   : "j$v\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns=g:default',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "204"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo',
      \           'key_input'   : "jwv$h\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns=g:default',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "205"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'f',
      \           'key_input'   : "jwv$h\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns=g:default',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "206"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'oo',
      \           'key_input'   : "jwlv$h\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns=g:default',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "207"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'fo',
      \           'key_input'   : "jwlv$h\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns=g:default',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "208"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz',
      \           'key_input'   : "jfbv$h\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns=g:default',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "209"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar',
      \           'key_input'   : "jfbv$h\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns=g:default',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "210"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o b',
      \           'key_input'   : "jfbv$h\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns=g:default',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "211"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'o bar  foo b',
      \           'key_input'   : "jfbv$h\<M-h>\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns=g:default',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 0']},
      \           'post' : {}
      \           },
      \
      \ "212"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'oo',
      \           'key_input'   : "jwlv$h\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns=g:default',
      \                                   'let @* = "nul"',
      \                                   'let g:patternjump_swap_head_tail = 1']},
      \           'post' : {}
      \           },
      \
      \ "213"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'fo',
      \           'key_input'   : "jwlv$h\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 1']}, 'post' : {}
      \           },
      \
      \ "214"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz',
      \           'key_input'   : "jfbv$h\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 1']}, 'post' : {}
      \           },
      \
      \ "215"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar',
      \           'key_input'   : "jfbv$h\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 1']}, 'post' : {}
      \           },
      \
      \ "216"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'b',
      \           'key_input'   : "jfbv$h\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 1']}, 'post' : {}
      \           },
      \
      \ "217"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo b',
      \           'key_input'   : "jfbv$h\<M-h>\<M-h>\<M-h>\<M-h>y",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 1']}, 'post' : {}
      \           },
      \
      \ "218"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'baz  ',
      \           'key_input'   : "j$y\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 1']}, 'post' : {}
      \           },
      \
      \ "219"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'bar baz  ',
      \           'key_input'   : "j$y2\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 1']}, 'post' : {}
      \           },
      \
      \ "220"  : {'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'foo bar baz  ',
      \           'key_input'   : "j$y3\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'let @* = "nul"', 'let g:patternjump_swap_head_tail = 1']}, 'post' : {}
      \           },
      \
      \ "221" : { 'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'fooa bar',
      \           'key_input'   : ":i\<CR>foo bar\<M-h>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:default',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "222" : { 'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'fooa,bar',
      \           'key_input'   : ":i\<CR>foo,bar\<M-h>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:default',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "223" : { 'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'fooa)bar',
      \           'key_input'   : ":i\<CR>foo)bar\<M-h>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:default',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "224" : { 'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'fooa]bar',
      \           'key_input'   : ":i\<CR>foo]bar\<M-h>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:default',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "225" : { 'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'fooa}bar',
      \           'key_input'   : ":i\<CR>foo}bar\<M-h>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:default',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "226" : { 'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'afoobar',
      \           'key_input'   : ":i\<CR>foobar\<M-h>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:default',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "227" : { 'caption'     : 'default pattern',
      \           'result'      : 'substitute(@*, ''\n'', "", "g")',
      \           'expectation' : 'fooaBar',
      \           'key_input'   : ":i\<CR>fooBar\<M-h>a\<CR>.\<CR>0y$",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre'  : {'commands' : ['let g:patternjump_patterns = g:default',
      \                                   'let @* = "nul"']},
      \           'post' : {}
      \           },
      \
      \ "228"  : {'caption'     : 'special pattern 1',
      \           'result'      : 'col(".")',
      \           'expectation' : '1',
      \           'key_input'   : "j2l\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:special_pattern1']}, 'post' : {}
      \           },
      \
      \ "229"  : {'caption'     : 'special pattern 2',
      \           'result'      : 'col(".")',
      \           'expectation' : '1',
      \           'key_input'   : "j2l\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:special_pattern2']}, 'post' : {}
      \           },
      \
      \ "230"  : {'caption'     : 'special pattern 3',
      \           'result'      : 'col(".")',
      \           'expectation' : '6',
      \           'key_input'   : "j2l\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:special_pattern3']}, 'post' : {}
      \           },
      \
      \ "231"  : {'caption'     : 'special pattern 4',
      \           'result'      : 'col(".")',
      \           'expectation' : '6',
      \           'key_input'   : "j2l\<M-h>",
      \           'breaking'    : 1,
      \           'abort'       : 0,
      \           'pre' : {'commands' : [':let g:patternjump_patterns=g:special_pattern4']}, 'post' : {}
      \           },
      \
      \ "post" : {'breaking' : 1},
      \ }

let test_info.post     = {
    \   'breaking' : 0,
    \   'commands' : []}

let test_info.n        = { 'title' : { 'title' : 'Test', 'post' : {'line' : {'char' : '-', 'width' : 60 } } }, 'post' : { 'line' : {'char' : '-', 'width' : 60 } } }
"}}}

" define Required functions"{{{
function! s:buffer_configuration(test_info)  "{{{
  if expand("%") != a:test_info.general.test_script
    if filereadable(a:test_info.general.test_script)
      setlocal noswapfile
      lcd %:p:h
      execute 'edit ' . a:test_info.general.test_script
    else
      return 1
    endif
  elseif expand("%:t") == a:test_info.general.test_script
    lcd %:h
  else
    return 1
  endif

  simalt ~x

  let s:scrollopt = &scrollopt
  set scrollopt-=jump
  setlocal scrollbind
  setlocal buftype=nowrite
  let s:test_script_tab_nr    = tabpagenr()
  let s:test_script_win_nr    = winnr()
  let s:test_script_buf_nr    = bufnr('%')
  let s:commentstring         = a:test_info.general.commentstring
  let s:caption_result        = a:test_info.general.caption_result
  let s:caption_expectation   = a:test_info.general.caption_expectation
  let s:minimum_caption_width = a:test_info.general.minimum_caption_width
  " save the containts of registers
  let s:reg_q     = getreg('q')
  let s:reg_slash = getreg("/")
  " Preparing ProcessManager module from vital.vim
  if !exists('s:V')
    let s:V  = vital#of('scilabcomplete')
    let s:PM = s:V.import('ProcessManager')
    let s:S  = s:V.import("Data.List")
  endif
  " Preparing result buffer
  execute a:test_info.general.split_command

  let s:result_tab_nr = tabpagenr()
  let s:result_win_nr = winnr()
  let s:result_buf_nr = bufnr('%')
  setlocal scrollbind
  setlocal noautoindent
  setlocal nosmartindent
  setlocal nocindent
  setlocal nohlsearch
  setlocal nowrapscan
  setlocal buftype=nowrite
  " Highlighting settings
  hi! link ScilabCompleteTestComment    Comment
  hi! link ScilabCompleteTestUnderlined Underlined
  hi! link ScilabCompleteTestPassed     Diffadd
  hi! link ScilabCompleteTestFailed     DiffDelete
  hi! link ScilabCompleteTestAbort      DiffChange
  hi! link ScilabCompleteTestBad        SpellBad
  hi! link ScilabCompleteTestCap        SpellCap
  call matchadd("ScilabCompleteTestComment",    '\%1l')
  call matchadd("ScilabCompleteTestComment",    '^\d\+-\d\+\ .*\ze:')
  call matchadd("ScilabCompleteTestUnderlined", '^' . s:caption_result)
  call matchadd("ScilabCompleteTestUnderlined", '^' . s:caption_expectation)

  if s:result_win_nr == s:test_script_win_nr
    return 1
  endif

  return 0
endfunction
"}}}
function! s:move_to_test_script()   "{{{
  execute 'tabnext ' . s:test_script_tab_nr
  execute s:test_script_tab_nr . 'wincmd w'
  execute 'buffer ' . s:test_script_buf_nr
endfunction
"}}}
function! s:move_to_result_buffer()   "{{{
  execute 'tabnext ' . s:result_tab_nr
  execute s:result_win_nr . 'wincmd w'
  execute 'buffer ' . s:result_buf_nr
endfunction
"}}}

function! s:write_down(line)    "{{{
  if line('.') == 1
    execute 'normal! i' . a:line
  else
    execute 'normal! o' . a:line
  endif
endfunction
"}}}
function! s:generate_caption(draft)  "{{{
  let caption     = ''
  let draft_width = len(a:draft)
  let spacing     = s:minimum_caption_width - draft_width

  if spacing > 0
    let caption = a:draft . repeat(' ', spacing)
"   elseif spacing < 0
"     let caption = a:draft[:spacing-1]
  else
    let caption = a:draft
  endif
  let caption = caption . ": "

  return caption
endfunction
"}}}
function! s:insert_template_pre(dict)    "{{{
  if !has_key(a:dict, 'pre')
    return
  endif

  if type(a:dict.pre) == type([])
    for order in a:dict.pre
      execute order
    endfor
  elseif type(a:dict.pre) == type({})
    if has_key(a:dict.pre, 'breaking')
      if a:dict.pre.breaking > 0
        if type(a:dict.pre.breaking) == type(0) && a:dict.pre.breaking > 0
          execute "normal! " . a:dict.pre.breaking . "o"
        endif
      endif
    endif

    if has_key(a:dict.pre, 'text')
      if type(a:dict.pre.text) == type('')
        call s:write_down(a:dict.pre.text)
        call matchadd("ScilabCompleteTestComment", '\%' . line('.') . 'l')
      elseif type(a:dict.pre.text) == type([])
        " don't know why, but it didn't works
        " call append(line('.'), a:dict.pre.text)
        for line in a:dict.pre.text
          call s:write_down(line)
          call matchadd("ScilabCompleteTestComment", '\%' . line('.') . 'l')
        endfor
      endif
    endif

    if has_key(a:dict.pre, 'line')
      normal! o
      execute "normal! " . printf("%s", a:dict.pre.line.width) . "i" . printf("%s", a:dict.pre.line.char)
      call matchadd("ScilabCompleteTestComment", '^' . a:dict.pre.line.char . '\{' . a:dict.pre.line.width . '}')
    endif
  endif
endfunction
"}}}
function! s:insert_template_title(dict)  "{{{
  if !has_key(a:dict, 'title')
    return
  endif

  if has_key(a:dict, 'title')
    if type(a:dict.title) == type('')
      call s:write_down(a:dict.title . ' ' . join(a:dict.address, '.'))
      call matchadd("ScilabCompleteTestComment", '\%' . line('.') . 'l')
    elseif type(a:dict.title) == type({})
      if has_key(a:dict.title, 'pre')
        call s:insert_template_pre(a:dict.title)
      endif

      if has_key(a:dict.title, 'title')
        if type(a:dict.title.title) == type('')
          call s:write_down(a:dict.title.title . ' ' . join(a:dict.address, '.'))
          call matchadd("ScilabCompleteTestComment", '\%' . line('.') . 'l')
        endif
      endif

      if has_key(a:dict.title, 'post')
        call s:insert_template_post(a:dict.title)
      endif
    endif
  endif
endfunction
"}}}
function! s:insert_template_cap(dict)  "{{{
  if !has_key(a:dict, 'caption')
    return
  endif

  if has_key(a:dict, 'caption')
    if type(a:dict.caption) == type('')
      let label_nr = join(a:dict.address, '.')
      let caption = s:generate_caption(label_nr . " " . a:dict.caption)
      call s:write_down(caption)
    elseif type(a:dict.caption) == type({})
      if has_key(a:dict.caption, 'pre')
        call s:insert_template_pre(a:dict.caption)
      endif

      if has_key(a:dict.caption, 'caption')
        let label_nr = join(a:dict.address, '-')
        let caption = s:generate_caption(label_nr . " " . a:dict.caption.caption)
        call s:write_down(caption)
      endif

      if has_key(a:dict.caption, 'post')
        call s:insert_template_post(a:dict.caption)
      endif
    endif
  endif
endfunction
"}}}
function! s:insert_template_res(dict)  "{{{
  if !has_key(a:dict, 'result')
    return
  endif

  if has_key(a:dict, 'result')
    let caption = s:generate_caption(s:caption_result)
    call s:write_down(caption)
  endif
endfunction
"}}}
function! s:insert_template_exp(dict)  "{{{
  if !has_key(a:dict, 'expectation')
    return
  endif

  if has_key(a:dict, 'expectation')
    let caption = s:generate_caption(s:caption_expectation)
    call s:write_down(caption . a:dict.expectation)
    if  has_key(a:dict, 'breaking')
      if type(a:dict.breaking) == type(0) && a:dict.breaking > 0
        execute "normal! " . a:dict.breaking . "o"
      endif
    endif
  endif
endfunction
"}}}
function! s:insert_template_post(dict)    "{{{
  if !has_key(a:dict, 'post')
    return
  endif

  if type(a:dict.post) == type([])
    for order in a:dict.post
      execute order
    endfor
  elseif type(a:dict.post) == type({})
    if has_key(a:dict.post, 'line')
      normal! o
      execute "normal! " . printf("%s", a:dict.post.line.width) . "i" . printf("%s", a:dict.post.line.char)
      call matchadd("ScilabCompleteTestComment", '^' . a:dict.post.line.char . '\{' . a:dict.post.line.width . '}')
    endif

    if has_key(a:dict.post, 'text')
      if type(a:dict.post.text) == type('')
        call s:write_down(a:dict.post.text)
        call matchadd("ScilabCompleteTestComment", '\%' . line('.') . 'l')
      elseif type(a:dict.post.text) == type([])
        " don't know why, but it didn't works
        " call append(line('.'), a:dict.post.text)
        for line in a:dict.post.text
          call s:write_down(line)
          call matchadd("ScilabCompleteTestComment", '\%' . line('.') . 'l')
        endfor
      endif
    endif

    if has_key(a:dict.post, 'breaking')
      if a:dict.post.breaking > 0
        if type(a:dict.post.breaking) == type(0) && a:dict.post.breaking > 0
          execute "normal! " . a:dict.post.breaking . "o"
        endif
      endif
    endif
  endif
endfunction
"}}}
function! s:extend_public_factor(dict, test_info, current_address)    "{{{
  let dict = a:dict
  let public = a:test_info
  let idx = 0
  if !empty(a:current_address)
    while idx < len(a:current_address)
      if has_key(public, 'n')
        let public = public.n
      else
        let public = {}
        break
      endif
      let idx += 1
    endwhile
  else
    let public = {}
  endif

  if has_key(public, 'pre')
    if has_key(dict, 'pre')
      call extend(dict.pre, public.pre, 'keep')
    else
      let dict.pre = public.pre
    endif
  endif

  if has_key(public, 'title')
    if has_key(dict, 'title')
      call extend(dict.title, public.title, 'keep')
    else
      let dict.title = public.title
    endif
  endif

  if has_key(public, 'label')
    if has_key(dict, 'label')
      call extend(dict.label, public.label, 'keep')
    else
      let dict.label = public.label
    endif
  endif

  if has_key(public, 'post')
    if has_key(dict, 'post')
      call extend(dict.post, public.post, 'keep')
    else
      let dict.post = public.post
    endif
  endif

  return dict
endfunction
"}}}

function! s:run_key_input(dict)    "{{{
  if get(a:dict, 'switch', 'on') !=? 'off'
    if has_key(a:dict, 'caption')
      call s:move_to_test_script()
      normal! gg

      call search(s:commentstring . join(a:dict.address, '\.') . ' ' . a:dict.caption)
      normal! j0
      if has_key(a:dict, 'key_input')
        call setreg('q', a:dict.key_input)
        normal! @q
      endif
    endif
  endif
endfunction
"}}}
function! s:copy_result(dict, quit_flag)   "{{{
  if get(a:dict, 'switch', 'on') !=? 'off'
    if a:quit_flag == 0
      if has_key(a:dict, 'result')
        let final_result = eval(a:dict.result)
        call s:move_to_result_buffer()
        normal! gg
        call search('^' . join(a:dict.address, '\.') . ' ' . a:dict.caption)
        execute "normal! jA" . final_result
      endif
    endif
  endif
endfunction
"}}}
function! s:judge(dict, quit_flag) "{{{
  let failed = []

  if has_key(a:dict, 'caption')
    let failed = [1]
    call s:move_to_result_buffer()
    normal! gg

    let matched_line = search('^' . join(a:dict.address, '\.') . ' ' . a:dict.caption)
    let caption_res  = s:generate_caption(s:caption_result)
    let caption_exp  = s:generate_caption(s:caption_expectation)
    let result       = matchstr(getline(matched_line + 1), '^' . caption_res . '\zs.*')
    let expectation  = matchstr(getline(matched_line + 2), '^' . caption_exp . '\zs.*')
    if get(a:dict, 'switch', 'on') ==? 'off'
      normal! ASkipped
      call matchadd("ScilabCompleteTestAbort", join(a:dict.address, '.') . ' ' . a:dict.caption . ' *: \zs.*')
    elseif a:quit_flag > 0
      normal! AAbort
      call matchadd("ScilabCompleteTestAbort", join(a:dict.address, '.') . ' ' .a:dict.caption . ' *: \zs.*')
    elseif result ==# expectation
      let failed = [0]
      normal! APassed
      call matchadd("ScilabCompleteTestPassed", join(a:dict.address, '.') . ' ' .a:dict.caption . ' *: \zs.*')
    else
      normal! AFailed
      call matchadd("ScilabCompleteTestFailed", join(a:dict.address, '.') . ' ' .a:dict.caption . ' *: \zs.*')
      let pos = 0
      while pos <= len(result)
        let c_res = result[pos]
        let c_exp = expectation[pos]
        if c_res !=# c_exp
          break
        endif
        let pos += 1
      endwhile
      call matchadd("ScilabCompleteTestBad", '\%' . printf("%s", matched_line + 1) . 'l\%' . printf("%s", pos + len(caption_res) + 1) . 'c\zs.*')
      call matchadd("ScilabCompleteTestCap", '\%' . printf("%s", matched_line + 2) . 'l\%' . printf("%s", pos + len(caption_exp) + 1) . 'c\zs.*')
    endif
    normal! 0
  endif

  return failed
endfunction
"}}}
function! s:run_commands(dict)   "{{{
  let failed = []

  if get(a:dict, 'switch', 'on') !=? 'off'
    call s:move_to_test_script()
    if has_key(a:dict, 'commands')
      if type(a:dict.commands) == type('')
        if a:dict.commands[0] == ":"
          let command = a:dict.commands
        else
          let command = ":" . a:dict.commands
        endif

        execute a:dict.commands
        call add(failed, 0)
      elseif type(a:dict.commands) == type([])
        for command in a:dict.commands
          if command[0] != ":"
            let command = ":" . command
          endif

          execute command
          call add(failed, 0)
        endfor
      endif
    endif
  endif

  return failed
endfunction
"}}}
function! s:touch_quit_info(dict, quit_info, failed, pos)  "{{{
  let quit_flag = a:quit_info.flag

  if !empty(a:failed)
    if has_key(a:dict, 'abort')
      let abort = a:dict.abort
    else
      let abort = 0
    endif

    if quit_flag == 0
      if a:pos ==# 'pre' || a:pos ==# 'post'
        if !empty(filter(a:failed, 'v:val != 0'))
          let a:quit_info.failed   = a:failed
          let a:quit_info.position = a:pos
          let a:quit_info.flag     = 1
        endif
      elseif a:pos ==# 'test'
        if and(abort, a:failed[0])
          let a:quit_info.failed   = a:failed
          let a:quit_info.position = a:pos
          let a:quit_info.flag     = 1
        endif
      endif
    endif
  endif
endfunction
"}}}

function! s:test_main_func(test_info)    "{{{
  call s:move_to_result_buffer()

  let glanced_nrs     = []
  let current_address = []
  let post_stack      = []
  let dict            = a:test_info
  let n_loop          = 0

  let quit_info = { 'flag' : 0,  'address' : [], 'failed' : [], 'position' : ''}
  let failed = []

  while n_loop < 1000
    let address = {'address' : current_address}
    call extend(dict, address, "force")

    let dict = s:extend_public_factor(dict, a:test_info, current_address)

    " expand template
    call s:move_to_result_buffer()
    normal! G
    call s:insert_template_pre(dict)
    call s:insert_template_title(dict)
    call s:insert_template_cap(dict)
    call s:insert_template_res(dict)
    call s:insert_template_exp(dict)

    " run test
    let quit_info.address = current_address

    let failed = s:run_commands(dict.pre)
    call s:touch_quit_info(dict, quit_info, failed, 'pre')

    call s:run_key_input(dict)
    call s:copy_result(dict, quit_info.flag)
    let failed = s:judge(dict, quit_info.flag)
    call s:touch_quit_info(dict, quit_info, failed, 'test')

    let failed = s:run_commands(dict.post)
    call s:touch_quit_info(dict, quit_info, failed, 'post')

    let nrs = s:S.sort(filter(keys(dict), 'v:val =~ ''\d\+'''), 'str2nr(a:a) - str2nr(a:b)')
    if !empty(nrs)
      call add(post_stack, join(current_address, '.'))

      let dict = dict[nrs[0]]
      call add(current_address, nrs[0])
      call add(glanced_nrs, deepcopy(nrs))
    else
      call s:move_to_result_buffer()
      normal! G
      call s:insert_template_post(dict)

      call remove(glanced_nrs[-1], 0)
      call remove(current_address, -1)
      let nr = get(glanced_nrs[-1], 0, -1)

      if nr >= 0
        call add(current_address, nr)

        execute 'let dict = a:test_info.' . join(current_address, '.')
        let address = {'address' : current_address}
        call extend(dict, address, "force")
      else
        call remove(glanced_nrs, -1)
        call remove(glanced_nrs[-1], 0)
        if !empty(glanced_nrs[0])
          call remove(current_address, -1)

          let address = {'address' : remove(post_stack, -1)}
          execute 'let dict = a:test_info.' . address.address
          call extend(dict, address, "force")

          let dict = s:extend_public_factor(dict, a:test_info, current_address)

          call s:move_to_result_buffer()
          normal! G
          call s:insert_template_post(dict)

          call add(current_address, glanced_nrs[-1][0])
          execute 'let dict = a:test_info.' . join(current_address, '.')

          let address = {'address' : current_address}
          call extend(dict, address, "force")

          let public = a:test_info
          let idx = 0
          while idx < len(current_address)
            if !has_key(public, 'n')
                let public = public.n
            else
                let public = {}
                break
            endif
            let idx += 1
          endwhile
          call extend(dict, public,  "keep")
        else
          let address = {'address' : remove(post_stack, -1)}
          execute 'let dict = a:test_info.' . address.address
          call extend(dict, address, "force")

          let dict = s:extend_public_factor(dict, a:test_info, current_address)

          call s:move_to_result_buffer()
          normal! G
          call s:insert_template_post(dict)
          call s:insert_template_post(a:test_info)
          break
        endif
      endif
    endif

    let n_loop += 1
  endwhile
endfunction
"}}}

function! s:finalize()   "{{{
  " Freeze result buffer
  call s:move_to_test_script()
  normal! gg
  call s:move_to_result_buffer()
  normal! gg
  setlocal nomodifiable
  " Restore global settings
  let &scrollopt = s:scrollopt
  " Restore registers
  let reg_q     = setreg('q', s:reg_q)
  let reg_slash = setreg("/", s:reg_slash)
endfunction
"}}}
"}}}

" Testing!
" buffer configuration
if !s:buffer_configuration(test_info)

  " Start test
  call s:test_main_func(test_info)

  " Finalize
  call s:finalize()
endif
