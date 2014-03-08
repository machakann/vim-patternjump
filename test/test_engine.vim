" vim:set foldmethod=marker:
" vim:set commentstring="%s:
" Last Change: 02-Mar-2014.

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

let g:default = {
    \ '_' : {
    \   'ci' : {
    \     'head' : [',', ')', ']', '}'],
    \     'tail' : ['\<\h\k*\>', '$'],
    \     },
    \   'nxo' : {
    \     'head' : ['\<\h\k*\>'],
    \     'tail' : ['$'],
    \     },
    \   },
    \ 'vim' : {
    \   'include' : '_',
    \   'nxo'     : {
    \     'head' : ['\<[abglstvw]:\k\+'],
    \     },
    \   },
    \ }

let g:example1 = {
    \ '_' : {
    \   'c' : {
    \     'head' : [',', ')', ']', '}'],
    \     'tail' : ['\<\h\k\+\>', '$'],
    \     },
    \   'i' : {
    \     'tail' : ['\<\h\k\+\>', '$'],
    \     },
    \   'nxo' : {
    \     'head' : ['\<\h\k\+\>'],
    \     'tail' : ['$'],
    \     },
    \   },
    \ 'vim' : {
    \   'include' : '_',
    \   'nxo'     : {
    \     'head' : ['\<[abglstvw]:\k\+'],
    \     },
    \   },
    \ }

let g:example2 = {
    \ '_' : {
    \   'ci' : {
    \     'head' : [',', ')', ']', '}'],
    \     'tail' : ['\<\h\k\+\>', '$'],
    \     },
    \   'nxo' : {
    \     'head' : ['\<\h\k\+\>'],
    \     'tail' : ['$'],
    \     },
    \   },
    \ 'SomeOtherFiletype' : {
    \   'nxo' : {
    \     'head' : ['foo'],
    \     'tail' : [':'],
    \     },
    \   },
    \ 'vim' : {
    \   'include' : ['_', 'SomeOtherFiletype'],
    \   'nxo'     : {
    \     'head' : ['\<[abglstvw]:\k\+'],
    \     },
    \   },
    \ }

let common_pattern = ['\<\h\k\+\>']
let g:example3 = {
    \ '_' : {
    \   'ci' : {
    \     'head' : [',', ')', ']', '}'],
    \     'tail' : ['$'] + common_pattern,
    \     },
    \   'nxo' : {
    \     'head' : common_pattern,
    \     'tail' : ['$'],
    \     },
    \   },
    \ 'vim' : {
    \   'include' : '_',
    \   'nxo'     : {
    \     'head' : ['\<[abglstvw]:\k\+'],
    \     },
    \   },
    \ }
unlet common_pattern

let g:example4 = {
    \ '_' : {
    \   'nxo' : {
    \     'head' : ['\<\h\k\+\>'],
    \     'tail' : ['$'],
    \     },
    \   },
    \ '*' : {
    \   'i' : {
    \     'head' : [',', ')', ']', '}'],
    \     'tail' : ['\<\h\k\+\>', '$'],
    \     },
    \   },
    \ 'vim' : {
    \   'include' : '_',
    \   'nxo'     : {
    \     'head' : ['\<[abglstvw]:\k\+'],
    \     },
    \   },
    \ }

let g:example5 = {
    \ '_' : {
    \   'ci'  : [',', ')', ']', '}'],
    \   'nxo' : ['\<\h\k\+\>'],
    \   },
    \ }

let g:example6 = {
    \ '_' : ['\<\h\k\+\>'],
    \ }

let common_pattern = {
    \    'head' : [',', ')', ']', '}'],
    \    'tail' : ['\<\h\k\+\>', '$'],
    \  }
let g:example7 = {
    \ '_' : {
    \   'nxo' : {
    \     'head' : ['\<\h\k\+\>'],
    \     'tail' : ['$'],
    \     },
    \   'c' : {
    \     'common' : common_pattern,
    \     },
    \   'i' : {
    \     'backward' : common_pattern,
    \     'forward'  : {'tail' : ['$']},
    \     },
    \   },
    \ 'vim' : {
    \   'include' : '_',
    \   'nxo'     : {
    \     'head' : ['\<[abglstvw]:\k\+'],
    \     },
    \   },
    \ }
unlet common_pattern

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

let g:elementary_pattern1 = {
    \ '_' : {
    \   'head'  : ['foo'],
    \   },
    \ }

let g:elementary_pattern2 = {
    \ '_' : {
    \   'tail'  : ['foo'],
    \   },
    \ }

let test_info.1       = {
    \   "pre"  : {'breaking' : 2, 'commands' : ':let g:patternjump_caching=0'},
    \   "1"    : {'caption'     : 'default pattern',
    \             'result'      : 'col(".")',
    \             'expectation' : '5',
    \             'key_input'   : "\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
    \             },
    \
    \   "2"    : {'caption'     : 'default pattern',
    \             'result'      : 'col(".")',
    \             'expectation' : '3',
    \             'key_input'   : "i\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
    \             },
    \
    \   "3"    : {'caption'     : 'default pattern',
    \             'result'      : 'col(".")',
    \             'expectation' : '8',
    \             'key_input'   : "i\<M-l>\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
    \             },
    \
    \   "4"    : {'caption'     : 'default pattern',
    \             'result'      : 'col(".")',
    \             'expectation' : '6',
    \             'key_input'   : "\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
    \             },
    \
    \   "5"    : {'caption'     : 'default pattern',
    \             'result'      : 'col(".")',
    \             'expectation' : '5',
    \             'key_input'   : "\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'set ft=vim']}, 'post' : {'commands' : ['set ft=']}
    \             },
    \
    \   "6"    : {'caption'     : 'example 1',
    \             'result'      : 'col(".")',
    \             'expectation' : '5',
    \             'key_input'   : "\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example1']}, 'post' : {}
    \             },
    \
    \   "7"    : {'caption'     : 'example 1',
    \             'result'      : 'col(".")',
    \             'expectation' : '9',
    \             'key_input'   : "i\<M-l>\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example1']}, 'post' : {}
    \             },
    \
    \   "8"    : {'caption'     : 'example 1',
    \             'result'      : 'col(".")',
    \             'expectation' : '8',
    \             'key_input'   : "i\<M-l>\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example1']}, 'post' : {}
    \             },
    \
    \   "9"    : {'caption'     : 'example 1',
    \             'result'      : 'col(".")',
    \             'expectation' : '6',
    \             'key_input'   : "\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example1']}, 'post' : {}
    \             },
    \
    \   "10"   : {'caption'     : 'example 1',
    \             'result'      : 'col(".")',
    \             'expectation' : '5',
    \             'key_input'   : "\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example1', 'set ft=vim']}, 'post' : {'commands' : ['set ft=']}
    \             },
    \
    \   "11"   : {'caption'     : 'example 2',
    \             'result'      : 'col(".")',
    \             'expectation' : '5',
    \             'key_input'   : "\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example2']}, 'post' : {}
    \             },
    \
    \   "12"   : {'caption'     : 'example 2',
    \             'result'      : 'col(".")',
    \             'expectation' : '3',
    \             'key_input'   : "i\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example2']}, 'post' : {}
    \             },
    \
    \   "13"   : {'caption'     : 'example 2',
    \             'result'      : 'col(".")',
    \             'expectation' : '8',
    \             'key_input'   : "i\<M-l>\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example2']}, 'post' : {}
    \             },
    \
    \   "14"   : {'caption'     : 'example 2',
    \             'result'      : 'col(".")',
    \             'expectation' : '6',
    \             'key_input'   : "\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example2']}, 'post' : {}
    \             },
    \
    \   "15"   : {'caption'     : 'example 2',
    \             'result'      : 'col(".")',
    \             'expectation' : '6',
    \             'key_input'   : "\<M-l>\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example2', 'set ft=vim']}, 'post' : {'commands' : ['set ft=']}
    \             },
    \
    \   "16"   : {'caption'     : 'example 3',
    \             'result'      : 'col(".")',
    \             'expectation' : '5',
    \             'key_input'   : "\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example3']}, 'post' : {}
    \             },
    \
    \   "17"   : {'caption'     : 'example 3',
    \             'result'      : 'col(".")',
    \             'expectation' : '3',
    \             'key_input'   : "i\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example3']}, 'post' : {}
    \             },
    \
    \   "18"   : {'caption'     : 'example 3',
    \             'result'      : 'col(".")',
    \             'expectation' : '8',
    \             'key_input'   : "i\<M-l>\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example3']}, 'post' : {}
    \             },
    \
    \   "19"   : {'caption'     : 'example 3',
    \             'result'      : 'col(".")',
    \             'expectation' : '6',
    \             'key_input'   : "\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example3']}, 'post' : {}
    \             },
    \
    \   "20"   : {'caption'     : 'example 3',
    \             'result'      : 'col(".")',
    \             'expectation' : '5',
    \             'key_input'   : "\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example3', 'set ft=vim']}, 'post' : {'commands' : ['set ft=']}
    \             },
    \
    \   "21"   : {'caption'     : 'example 4',
    \             'result'      : 'col(".")',
    \             'expectation' : '5',
    \             'key_input'   : "\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example4']}, 'post' : {}
    \             },
    \
    \   "22"   : {'caption'     : 'example 4',
    \             'result'      : 'col(".")',
    \             'expectation' : '3',
    \             'key_input'   : "i\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example4']}, 'post' : {}
    \             },
    \
    \   "23"   : {'caption'     : 'example 4',
    \             'result'      : 'col(".")',
    \             'expectation' : '8',
    \             'key_input'   : "i\<M-l>\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example4']}, 'post' : {}
    \             },
    \
    \   "24"   : {'caption'     : 'example 4',
    \             'result'      : 'col(".")',
    \             'expectation' : '6',
    \             'key_input'   : "\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example4']}, 'post' : {}
    \             },
    \
    \   "25"   : {'caption'     : 'example 4',
    \             'result'      : 'col(".")',
    \             'expectation' : '5',
    \             'key_input'   : "\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example4', 'set ft=vim']}, 'post' : {'commands' : ['set ft=']}
    \             },
    \
    \   "26"   : {'caption'     : 'example 5',
    \             'result'      : 'col(".")',
    \             'expectation' : '5',
    \             'key_input'   : "\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example5']}, 'post' : {}
    \             },
    \
    \   "27"   : {'caption'     : 'example 5',
    \             'result'      : 'col(".")',
    \             'expectation' : '4',
    \             'key_input'   : "i\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example5']}, 'post' : {}
    \             },
    \
    \   "28"   : {'caption'     : 'example 5',
    \             'result'      : 'col(".")',
    \             'expectation' : '8',
    \             'key_input'   : "i\<M-l>\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example5']}, 'post' : {}
    \             },
    \
    \   "29"   : {'caption'     : 'example 5',
    \             'result'      : 'col(".")',
    \             'expectation' : '1',
    \             'key_input'   : "\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example5']}, 'post' : {}
    \             },
    \
    \   "30"   : {'caption'     : 'example 5',
    \             'result'      : 'col(".")',
    \             'expectation' : '7',
    \             'key_input'   : "\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example5', 'set ft=vim']}, 'post' : {'commands' : ['set ft=']}
    \             },
    \
    \   "31"   : {'caption'     : 'example 6',
    \             'result'      : 'col(".")',
    \             'expectation' : '5',
    \             'key_input'   : "\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example6']}, 'post' : {}
    \             },
    \
    \   "32"   : {'caption'     : 'example 6',
    \             'result'      : 'col(".")',
    \             'expectation' : '6',
    \             'key_input'   : "i\<M-l>\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example6']}, 'post' : {}
    \             },
    \
    \   "33"   : {'caption'     : 'example 6',
    \             'result'      : 'col(".")',
    \             'expectation' : '5',
    \             'key_input'   : "i\<M-l>\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example6']}, 'post' : {}
    \             },
    \
    \   "34"   : {'caption'     : 'example 6',
    \             'result'      : 'col(".")',
    \             'expectation' : '1',
    \             'key_input'   : "\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example6']}, 'post' : {}
    \             },
    \
    \   "35"   : {'caption'     : 'example 6',
    \             'result'      : 'col(".")',
    \             'expectation' : '7',
    \             'key_input'   : "\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example6', 'set ft=vim']}, 'post' : {'commands' : ['set ft=']}
    \             },
    \
    \   "36"   : {'caption'     : 'example 7',
    \             'result'      : 'col(".")',
    \             'expectation' : '5',
    \             'key_input'   : "\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example7']}, 'post' : {}
    \             },
    \
    \   "37"   : {'caption'     : 'example 7',
    \             'result'      : 'col(".")',
    \             'expectation' : '9',
    \             'key_input'   : "i\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example7']}, 'post' : {}
    \             },
    \
    \   "38"   : {'caption'     : 'example 7',
    \             'result'      : 'col(".")',
    \             'expectation' : '9',
    \             'key_input'   : "i\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example7']}, 'post' : {}
    \             },
    \
    \   "39"   : {'caption'     : 'example 7',
    \             'result'      : 'col(".")',
    \             'expectation' : '6',
    \             'key_input'   : "\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example7']}, 'post' : {}
    \             },
    \
    \   "40"   : {'caption'     : 'example 7',
    \             'result'      : 'col(".")',
    \             'expectation' : '5',
    \             'key_input'   : "\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example7', 'set ft=vim']}, 'post' : {'commands' : ['set ft=']}
    \             },
    \
    \   "41"   : {'caption'     : 'special pattern 1',
    \             'result'      : 'col(".")',
    \             'expectation' : '3',
    \             'key_input'   : "2l\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:special_pattern1']}, 'post' : {}
    \             },
    \
    \   "42"   : {'caption'     : 'special pattern 2',
    \             'result'      : 'col(".")',
    \             'expectation' : '3',
    \             'key_input'   : "2l\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:special_pattern2']}, 'post' : {}
    \             },
    \
    \   "43"   : {'caption'     : 'special pattern 3',
    \             'result'      : 'col(".")',
    \             'expectation' : '6',
    \             'key_input'   : "2l\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:special_pattern3']}, 'post' : {}
    \             },
    \
    \   "44"   : {'caption'     : 'special pattern 4',
    \             'result'      : 'col(".")',
    \             'expectation' : '6',
    \             'key_input'   : "2l\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:special_pattern4']}, 'post' : {}
    \             },
    \
    \   "45"   : {'caption'     : 'elementary pattern 1',
    \             'result'      : 'col(".")',
    \             'expectation' : '5',
    \             'key_input'   : "\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:elementary_pattern1']}, 'post' : {}
    \             },
    \
    \   "46"   : {'caption'     : 'elementary pattern 1',
    \             'result'      : 'col(".")',
    \             'expectation' : '4',
    \             'key_input'   : "i\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:elementary_pattern1']}, 'post' : {}
    \             },
    \
    \   "47"   : {'caption'     : 'elementary pattern 2',
    \             'result'      : 'col(".")',
    \             'expectation' : '7',
    \             'key_input'   : "\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:elementary_pattern2']}, 'post' : {}
    \             },
    \
    \   "48"   : {'caption'     : 'elementary pattern 2',
    \             'result'      : 'col(".")',
    \             'expectation' : '7',
    \             'key_input'   : "i\<M-l>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:elementary_pattern2']}, 'post' : {}
    \             },
    \
    \   "post" : {'breaking' : 1},
    \   }

let test_info.2       = {
    \   "pre"  : {'breaking' : 0, 'commands' : ':let g:patternjump_caching=0'},
    \   "1"    : {'caption'     : 'default pattern',
    \             'result'      : 'col(".")',
    \             'expectation' : '5',
    \             'key_input'   : "$\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
    \             },
    \
    \   "2"    : {'caption'     : 'default pattern',
    \             'result'      : 'col(".")',
    \             'expectation' : '3',
    \             'key_input'   : "$a\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
    \             },
    \
    \   "3"    : {'caption'     : 'default pattern',
    \             'result'      : 'col(".")',
    \             'expectation' : '8',
    \             'key_input'   : "$a\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
    \             },
    \
    \   "4"    : {'caption'     : 'default pattern',
    \             'result'      : 'col(".")',
    \             'expectation' : '1',
    \             'key_input'   : "$\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:default']}, 'post' : {}
    \             },
    \
    \   "5"    : {'caption'     : 'default pattern',
    \             'result'      : 'col(".")',
    \             'expectation' : '5',
    \             'key_input'   : "$\<M-h>\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:default', 'set ft=vim']}, 'post' : {'commands' : ['set ft=']}
    \             },
    \
    \   "6"    : {'caption'     : 'example 1',
    \             'result'      : 'col(".")',
    \             'expectation' : '5',
    \             'key_input'   : "$\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example1']}, 'post' : {}
    \             },
    \
    \   "7"    : {'caption'     : 'example 1',
    \             'result'      : 'col(".")',
    \             'expectation' : '3',
    \             'key_input'   : "A\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example1']}, 'post' : {}
    \             },
    \
    \   "8"    : {'caption'     : 'example 1',
    \             'result'      : 'col(".")',
    \             'expectation' : '3',
    \             'key_input'   : "A\<M-h>\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example1']}, 'post' : {}
    \             },
    \
    \   "9"    : {'caption'     : 'example 1',
    \             'result'      : 'col(".")',
    \             'expectation' : '1',
    \             'key_input'   : "$\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example1']}, 'post' : {}
    \             },
    \
    \   "10"   : {'caption'     : 'example 1',
    \             'result'      : 'col(".")',
    \             'expectation' : '5',
    \             'key_input'   : "$\<M-h>\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example1', 'set ft=vim']}, 'post' : {'commands' : ['set ft=']}
    \             },
    \
    \   "11"   : {'caption'     : 'example 2',
    \             'result'      : 'col(".")',
    \             'expectation' : '5',
    \             'key_input'   : "$\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example2']}, 'post' : {}
    \             },
    \
    \   "12"   : {'caption'     : 'example 2',
    \             'result'      : 'col(".")',
    \             'expectation' : '4',
    \             'key_input'   : "A\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example2']}, 'post' : {}
    \             },
    \
    \   "13"   : {'caption'     : 'example 2',
    \             'result'      : 'col(".")',
    \             'expectation' : '3',
    \             'key_input'   : "A\<M-h>\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example2']}, 'post' : {}
    \             },
    \
    \   "14"   : {'caption'     : 'example 2',
    \             'result'      : 'col(".")',
    \             'expectation' : '1',
    \             'key_input'   : "$\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example2']}, 'post' : {}
    \             },
    \
    \   "15"   : {'caption'     : 'example 2',
    \             'result'      : 'col(".")',
    \             'expectation' : '6',
    \             'key_input'   : "$\<M-h>\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example2', 'set ft=vim']}, 'post' : {'commands' : ['set ft=']}
    \             },
    \
    \   "16"   : {'caption'     : 'example 3',
    \             'result'      : 'col(".")',
    \             'expectation' : '5',
    \             'key_input'   : "$\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example3']}, 'post' : {}
    \             },
    \
    \   "17"   : {'caption'     : 'example 3',
    \             'result'      : 'col(".")',
    \             'expectation' : '3',
    \             'key_input'   : "A\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example3']}, 'post' : {}
    \             },
    \
    \   "18"   : {'caption'     : 'example 3',
    \             'result'      : 'col(".")',
    \             'expectation' : '3',
    \             'key_input'   : "A\<M-h>\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example3']}, 'post' : {}
    \             },
    \
    \   "19"   : {'caption'     : 'example 3',
    \             'result'      : 'col(".")',
    \             'expectation' : '1',
    \             'key_input'   : "$\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example3']}, 'post' : {}
    \             },
    \
    \   "20"   : {'caption'     : 'example 3',
    \             'result'      : 'col(".")',
    \             'expectation' : '5',
    \             'key_input'   : "$\<M-h>\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example3', 'set ft=vim']}, 'post' : {'commands' : ['set ft=']}
    \             },
    \
    \   "21"   : {'caption'     : 'example 4',
    \             'result'      : 'col(".")',
    \             'expectation' : '5',
    \             'key_input'   : "$\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example4']}, 'post' : {}
    \             },
    \
    \   "22"   : {'caption'     : 'example 4',
    \             'result'      : 'col(".")',
    \             'expectation' : '3',
    \             'key_input'   : "A\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example4']}, 'post' : {}
    \             },
    \
    \   "23"   : {'caption'     : 'example 4',
    \             'result'      : 'col(".")',
    \             'expectation' : '3',
    \             'key_input'   : "A\<M-h>\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example4']}, 'post' : {}
    \             },
    \
    \   "24"   : {'caption'     : 'example 4',
    \             'result'      : 'col(".")',
    \             'expectation' : '1',
    \             'key_input'   : "$\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example4']}, 'post' : {}
    \             },
    \
    \   "25"   : {'caption'     : 'example 4',
    \             'result'      : 'col(".")',
    \             'expectation' : '5',
    \             'key_input'   : "$\<M-h>\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example4', 'set ft=vim']}, 'post' : {'commands' : ['set ft=']}
    \             },
    \
    \   "26"   : {'caption'     : 'example 5',
    \             'result'      : 'col(".")',
    \             'expectation' : '5',
    \             'key_input'   : "$\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example5']}, 'post' : {}
    \             },
    \
    \   "27"   : {'caption'     : 'example 5',
    \             'result'      : 'col(".")',
    \             'expectation' : '4',
    \             'key_input'   : "A\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example5']}, 'post' : {}
    \             },
    \
    \   "28"   : {'caption'     : 'example 5',
    \             'result'      : 'col(".")',
    \             'expectation' : '8',
    \             'key_input'   : "A\<M-h>\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example5']}, 'post' : {}
    \             },
    \
    \   "29"   : {'caption'     : 'example 5',
    \             'result'      : 'col(".")',
    \             'expectation' : '1',
    \             'key_input'   : "$\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example5']}, 'post' : {}
    \             },
    \
    \   "30"   : {'caption'     : 'example 5',
    \             'result'      : 'col(".")',
    \             'expectation' : '1',
    \             'key_input'   : "$\<M-h>\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example5', 'set ft=vim']}, 'post' : {'commands' : ['set ft=']}
    \             },
    \
    \   "31"   : {'caption'     : 'example 6',
    \             'result'      : 'col(".")',
    \             'expectation' : '5',
    \             'key_input'   : "$\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example6']}, 'post' : {}
    \             },
    \
    \   "32"   : {'caption'     : 'example 6',
    \             'result'      : 'col(".")',
    \             'expectation' : '1',
    \             'key_input'   : "A\<M-h>\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example6']}, 'post' : {}
    \             },
    \
    \   "33"   : {'caption'     : 'example 6',
    \             'result'      : 'col(".")',
    \             'expectation' : '1',
    \             'key_input'   : "A\<M-h>\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example6']}, 'post' : {}
    \             },
    \
    \   "34"   : {'caption'     : 'example 6',
    \             'result'      : 'col(".")',
    \             'expectation' : '1',
    \             'key_input'   : "$\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example6']}, 'post' : {}
    \             },
    \
    \   "35"   : {'caption'     : 'example 6',
    \             'result'      : 'col(".")',
    \             'expectation' : '1',
    \             'key_input'   : "$\<M-h>\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example6', 'set ft=vim']}, 'post' : {'commands' : ['set ft=']}
    \             },
    \
    \   "36"   : {'caption'     : 'example 7',
    \             'result'      : 'col(".")',
    \             'expectation' : '5',
    \             'key_input'   : "$\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example7']}, 'post' : {}
    \             },
    \
    \   "37"   : {'caption'     : 'example 7',
    \             'result'      : 'col(".")',
    \             'expectation' : '4',
    \             'key_input'   : "A\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example7']}, 'post' : {}
    \             },
    \
    \   "38"   : {'caption'     : 'example 7',
    \             'result'      : 'col(".")',
    \             'expectation' : '8',
    \             'key_input'   : "A\<M-h>\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example7']}, 'post' : {}
    \             },
    \
    \   "39"   : {'caption'     : 'example 7',
    \             'result'      : 'col(".")',
    \             'expectation' : '1',
    \             'key_input'   : "$\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example7']}, 'post' : {}
    \             },
    \
    \   "40"   : {'caption'     : 'example 7',
    \             'result'      : 'col(".")',
    \             'expectation' : '5',
    \             'key_input'   : "$\<M-h>\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:example7', 'set ft=vim']}, 'post' : {'commands' : ['set ft=']}
    \             },
    \
    \   "41"   : {'caption'     : 'special pattern 1',
    \             'result'      : 'col(".")',
    \             'expectation' : '1',
    \             'key_input'   : "2l\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:special_pattern1']}, 'post' : {}
    \             },
    \
    \   "42"   : {'caption'     : 'special pattern 2',
    \             'result'      : 'col(".")',
    \             'expectation' : '1',
    \             'key_input'   : "2l\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:special_pattern2']}, 'post' : {}
    \             },
    \
    \   "43"   : {'caption'     : 'special pattern 3',
    \             'result'      : 'col(".")',
    \             'expectation' : '3',
    \             'key_input'   : "2l\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:special_pattern3']}, 'post' : {}
    \             },
    \
    \   "44"   : {'caption'     : 'special pattern 4',
    \             'result'      : 'col(".")',
    \             'expectation' : '3',
    \             'key_input'   : "2l\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:special_pattern4']}, 'post' : {}
    \             },
    \
    \   "45"   : {'caption'     : 'elementary pattern 1',
    \             'result'      : 'col(".")',
    \             'expectation' : '5',
    \             'key_input'   : "$\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:elementary_pattern1']}, 'post' : {}
    \             },
    \
    \   "46"   : {'caption'     : 'elementary pattern 1',
    \             'result'      : 'col(".")',
    \             'expectation' : '4',
    \             'key_input'   : "A\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:elementary_pattern1']}, 'post' : {}
    \             },
    \
    \   "47"   : {'caption'     : 'elementary pattern 2',
    \             'result'      : 'col(".")',
    \             'expectation' : '7',
    \             'key_input'   : "$\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:elementary_pattern2']}, 'post' : {}
    \             },
    \
    \   "48"   : {'caption'     : 'elementary pattern 2',
    \             'result'      : 'col(".")',
    \             'expectation' : '7',
    \             'key_input'   : "A\<M-h>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:patternjump_patterns=g:elementary_pattern2']}, 'post' : {}
    \             },
    \
    \   "post" : {'breaking' : 1},
    \   }

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
