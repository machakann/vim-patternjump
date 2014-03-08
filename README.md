vim-patternjump
===============

Move cursor as you like.

#introduction
Patternjump give you a effective way to move cursor in various modes. The rules to move cursor can be easily optimized by using regular expression. In this introduction those rules defined by regular expression are called patterns. Please note it. Numbers of patterns can be registered and cursor would be moved to the closest candidate in them. This plugin serves two keymappings.  One searches candidates for forward direction, and the other searches them for backward direction.

Suppose that your cursor is on the first character of a line like this:

```vim
let foo = "bar"
```

If you define a pattern "bar", of course, it matches with "bar". Thus using the keymapping which searches candidates in forward direction, cursor will move on a word "bar". Here I should say there are two types of patterns, head-patterns and tail-patterns. All the patterns should belong to either head or tail patterns, you can choose which when you register a new pattern. If "bar" belongs to head-patterns, cursor will move on 'b' of "bar". And if "bar" belongs to tail-patterns, cursor will move on 'r' of "bar".

```vim
---------->#    head-pattern
let foo = "bar"                         '#' represents cursor position
------------>#  tail-pattern
```

I guess you have found that the pattern "bar" seems like not useful. Alternatively, a pattern '\<\h\k\+\>' is included in default patterns. This pattern matches with a independent word determined by the option 'iskeyword' in a source code.  Therefore cursor will stop at "let", "foo", "bar". I think they are the very what we want to correct when we review a source code in many cases.

```vim
#   #      #    head-pattern
let foo = "bar"                         '#' represents cursor position
  #   #      #  tail-pattern
```

Additionally, these patterns can be switched according to modes. In the default patterns, '\<\h\k\+\>' is belongs to head-patterns in normal mode, meanwhile it belongs to tail-patterns in insert mode. Because text-objects and {motion} gives us a excellent environment for editing in normal mode, if you want to cut a word and substitute to a correct word, press ciw or just cw in this case. On the other hand, we can not use text-objects in insert mode, however we can do some easy work also in insert mode. If you want to delete a word in front of cursor, you can use <C-w>. That is why the reason I defined the default patterns like this.

The patterns can be defined to use a dictionary like this:

```vim
let g:patternjump_patterns = {
    \ '_' : {
    \   'ci' : {
    \     'head' : [',', ')', ']', '}', '$'],
    \     'tail' : ['\<\h\k\+\>'],
    \     },
    \   'n' : {
    \     'head' : ['\<\h\k\+\>', '$'],
    \     },
    \   'x' : {
    \     'tail' : ['\<\h\k\+\>', '$'],
    \     },
    \   'o' : {
    \     'tail' : ['\<\h\k\+\>.'],
    \     },
    \   },
    \ 'vim' : {
    \   'include' : '_',
    \   'n'     : {
    \     'head' : ['\<[abglstvw]:\k\+'],
    \     },
    \   },
    \ }
```

This example is the default patterns which is used in the case any patterns assignment exists. You can use independent patterns in different filetypes, modes (normal/visual/operator-pending/insert/command-line), direction (forward/backward). If you are interested in the customization of patterns, please refer doc/patternjump.txt. You would find detailed information about the customization of patterns.
