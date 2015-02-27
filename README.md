vim-patternjump
===============

Move cursor as you like.

#introduction
Patternjump gives you a effective way to move cursor in various modes. The rules to move cursor can be easily optimized by using regular expression. In this introduction those rules defined by regular expression are called patterns. Numbers of patterns can be registered and cursor would be moved to the closest candidate in them. This plugin serves two keymappings.  One searches candidates for forward direction, and the other searches them for backward direction.

Suppose that your cursor is on the first character of a line like this:

```vim
let foo = "bar"
```

If you define a pattern `bar`, of course, it matches with `bar`. Thus using the keymapping which searches candidates in forward direction, cursor will move on a word `bar`. Here I should say there are two types of patterns, head-patterns and tail-patterns. All the patterns should belong to either head or tail patterns, you can choose which when you register a new pattern. If `bar` belongs to head-patterns, cursor will move on `b` of `bar`. And if `bar` belongs to tail-patterns, cursor will move on `r` of `bar`.

```vim
---------->#    head-pattern
let foo = "bar"                         '#' represents cursor position
------------>#  tail-pattern
```

I guess you have found that the pattern `bar` seems like not useful. Alternatively, a pattern `\<\h\k*\>` is included in default patterns. This pattern matches with a independent word determined by the option 'iskeyword' in a source code.  Therefore cursor will stop at `let`, `foo`, `bar`. I think they are the very what we want to correct when we review a source code in many cases.

```vim
#   #      #    head-pattern
let foo = "bar"                         '#' represents cursor position
  #   #      #  tail-pattern
```

The default mappings are assigned to `<M-l>` and `<M-h>`. `<M-l>` searches for candidates in forward direction and `<M-h>` searches for candidates in backward direction.

#Normal mode
`^\s*\zs\S`, `\<\h\k*\>`, `.$` belong to head-patterns in default. The first one matches with the first character of a line except for spaces, it is the equivalent to `^` command. `\<\h\k*\>` matches with a word. The last one is the last character of a line, but this pattern ignores the empty line. If the pattern `$` is used, patternjump stops cursor even on a empty line.

![patternjump-normal](http://kura3.photozou.jp/pub/986/3080986/photo/201082159_org.v1396763315.gif)



#Insert mode
`^\s*\zs\S`, `,`, `)`, `]`, `}` belong to head-patterns and `\<\h\k*\>`, `.$` belong to tail-patterns. In contrast to normal mode setting, `\<\h\k*\>` is a tail-pattern in insert mode. Because `i_CTRL w` is useful to delete a word in this case.

![patternjump-insert](http://kura2.photozou.jp/pub/986/3080986/photo/201082310_org.v1396763410.gif)



#Visual mode
`^\s*\zs\S`, `\<\h\k*\>`, `.$` belong to tail-patterns in default. The first and third patterns matches with a character, thus they work in same way as head-patterns in normal mode.

#Operator-pending mode
Patternjump is also valid in operator-pending mode. You can define your motions by using regular expression. When you define your motions, [exclusive](http://vimdoc.sourceforge.net/htmldoc/motion.html#exclusive) or [inclusive](http://vimdoc.sourceforge.net/htmldoc/motion.html#inclusive) motion can be chosen. `\<\h\k*\>` is used as tail-pattern in the forward directed mapping and is used as head-pattern in the backward directed mapping in default.



#Command-line mode
Patternjump can be used also in command-line mode. `^`, ` `, `/`, `[A-Z]`, `,`, `)`, `]`, `}`, `$` belong to head-patterns in default.

![patternjump-command-line](http://kura3.photozou.jp/pub/986/3080986/photo/201082357_org.v1396763410.gif)



#Customization
The patterns can be defined to use a dictionary like this:

```vim
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
```

This example is the default patterns which is used in the case any pattern assignment does not exist. If you are interested in the customization of patterns, please refer doc/patternjump.txt. You can use independent patterns in different filetypes, modes (normal/visual/operator-pending/insert/command-line), direction (forward/backward). You would find detailed information about the customization of patterns.
