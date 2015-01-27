" Vim filetype plugin file
" Language:	Javascript
" Maintainer:	Doug Kearns <dougkearns@gmail.com>
" Last Change:  2008 Jun 15
" URL:		http://gus.gscit.monash.edu.au/~djkea2/vim/ftplugin/javascript.vim

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo-=C

" Set 'formatoptions' to break comment lines but not other lines,
" " and insert the comment leader when hitting <CR> or using "o".
setlocal formatoptions-=t formatoptions+=croql

" Set completion with CTRL-X CTRL-O to autoloaded function.
if exists('&ofu')
    setlocal omnifunc=javascriptcomplete#CompleteJS
endif

" Set 'comments' to format dashed lists in comments.
setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://

setlocal commentstring=//%s


" indent setting
" ==============
" With "setlocal" only the local value is changed, thus this value is not 
" used when editing a new buffer.

" a four-space tab indent width is the prefered coding style for html.
setlocal tabstop=4

" amount of spaces you want for a deeper level
" And this allows you to use the < and > keys from visual mode to block
" indent/unindent regions
setlocal shiftwidth=4

" Insert spaces instead of <TAB> character when the <TAB> key is pressed.
" 为了兼容其他项目/人的代码，最好使用 tab 作为缩进符号，而不是使用写死个数的 SPACE.
"setlocal expandtab

" make VIM see multiple space characters as tabstops.
" it makes it easier when pressing BACKSPACE or DELETE.
setlocal softtabstop=4

" default is empty
" Make backspace delete lots of things. 
setlocal backspace=indent,eol,start

" show print margin
setlocal colorcolumn=79

" Change the :browse e filter to primarily show Java-related files.
if has("gui_win32")
    let  b:browsefilter="Javascript Files (*.js)\t*.js\n" .
		\	"All Files (*.*)\t*.*\n"
endif
       
let b:undo_ftplugin = "setl fo< ofu< com< cms<" 

let &cpo = s:cpo_save
unlet s:cpo_save
