" Vim filetype plugin file
" Language:         CSS
" Maintainer:       Nikolai Weibull <now@bitwi.se>
" Latest Revision:  2008-07-09

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

let b:undo_ftplugin = "setl com< cms< inc< fo< ofu<"

setlocal comments=s1:/*,mb:*,ex:*/ commentstring&
setlocal formatoptions-=t formatoptions+=croql
setlocal omnifunc=csscomplete#CompleteCSS


" indent setting
" ==============
" With "setlocal" only the local value is changed, thus this value is not 
" used when editing a new buffer.

" a four-space tab indent width is the prefered coding style for html.
setlocal tabstop=2

" amount of spaces you want for a deeper level
" And this allows you to use the < and > keys from visual mode to block
" indent/unindent regions
setlocal shiftwidth=2

" Insert spaces instead of <TAB> character when the <TAB> key is pressed.
setlocal expandtab

" make VIM see multiple space characters as tabstops.
" it makes it easier when pressing BACKSPACE or DELETE.
setlocal softtabstop=2

" default is empty
" Make backspace delete lots of things. 
setlocal backspace=indent,eol,start


let &l:include = '^\s*@import\s\+\%(url(\)\='

let &cpo = s:cpo_save
unlet s:cpo_save
