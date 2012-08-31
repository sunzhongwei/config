" Vim filetype plugin file
" Language:	python
" Maintainer:	Johannes Zellner <johannes@zellner.org>
" Last Change:	Wed, 21 Apr 2004 13:13:08 CEST

if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1

setlocal cinkeys-=0#
setlocal indentkeys-=0#
setlocal include=\s*\\(from\\\|import\\)
setlocal includeexpr=substitute(v:fname,'\\.','/','g')
setlocal suffixesadd=.py
setlocal comments-=:%
setlocal commentstring=#%s

setlocal omnifunc=pythoncomplete#Complete


" indent setting
" ==============
" Reference: http://henry.precheur.org/vim/python
" With "setlocal" only the local value is changed, thus this value is not 
" used when editing a new buffer.

" a four-space tab indent width is the prefered coding style for python.
setlocal tabstop=4

" amount of spaces you want for a deeper level
" And this allows you to use the < and > keys from visual mode to block
" indent/unindent regions
setlocal shiftwidth=4

" Insert spaces instead of <TAB> character when the <TAB> key is pressed.
setlocal expandtab

" make VIM see multiple space characters as tabstops.
" it makes it easier when pressing BACKSPACE or DELETE.
setlocal softtabstop=4

" default is empty
" Make backspace delete lots of things. 
setlocal backspace=indent,eol,start

" show print margin
setlocal colorcolumn=79

" 自动换行是每行超过 n 个字的时候 vim 自动加上换行符
" 需要注意的是，如果一个段落的首个单词很长，超出了自动换行设置的字符，
" 这种情况下不会换行。
" 于是，中文就悲剧了，因为中文中很少出现空格，字之间没有，句子之间也没有。
" 于是不会触发自动换行的处理。
" 对已经存在的文本，不做自动换行处理，只有新输入文本的才会触发。
" 如要对已存在的文本应用自动换行，只要选中它们，然后按gq就可以了。
setlocal textwidth=78
" 上面所说的中文不能自动换行的问题，可以通过下面的配置解决.
" m   Also break at a multi-byte character above 255.  This is useful for    
"     Asian text where every character is a word on its own.                 
" M   When joining lines, don't insert a space before or after a
"     multi-byte  character.  Overrules the 'B' flag.
setlocal formatoptions+=mM

" 自动折行是把长的一行用多行显示 , 不在文件里加换行符
" 设置自动折行(默认开启)
" set wrap
" 设置不自动折行
" set nowrap


set wildignore+=*.pyc

nnoremap <silent> <buffer> ]] :call <SID>Python_jump('/^\(class\\|def\)')<cr>
nnoremap <silent> <buffer> [[ :call <SID>Python_jump('?^\(class\\|def\)')<cr>
nnoremap <silent> <buffer> ]m :call <SID>Python_jump('/^\s*\(class\\|def\)')<cr>
nnoremap <silent> <buffer> [m :call <SID>Python_jump('?^\s*\(class\\|def\)')<cr>

if exists('*<SID>Python_jump') | finish | endif

fun! <SID>Python_jump(motion) range
    let cnt = v:count1
    let save = @/    " save last search pattern
    mark '
    while cnt > 0
	silent! exe a:motion
	let cnt = cnt - 1
    endwhile
    call histdel('/', -1)
    let @/ = save    " restore last search pattern
endfun

if has("gui_win32") && !exists("b:browsefilter")
    let b:browsefilter = "Python Files (*.py)\t*.py\n" .
		       \ "All Files (*.*)\t*.*\n"
endif
