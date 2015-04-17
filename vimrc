" --------------
" Vundle config
" --------------
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

Plugin 'scrooloose/nerdtree'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" All of your Plugins must be added before the following line
call vundle#end()            " required
" filetype indent on
" 使用 filetype 而不是 autocmd 做缩进配置的原因：
" http://henry.precheur.org/vim/python
" Generally don’t use the autocmd command to add hooks to a specific filename’s
" extension. AutoCmd ... *.py ... might look like a good way of executing
" commands when opening a Python file; it’s not. Because all Python filenames
" do not necessarily end with .py; some executable scripts might not have
" extension for example.
" 自动加载 ~/.vim/indent/<filetype>.vim
" vim7.3 自带了这些文件 /usr/local/share/vim/vim73/indent/python.vim
" 但是，还是 copy 到 ~/.vim/<indent/plugin>/ 做定制比较好
" 用于自动判定缩进，例如，换行时的缩进判定
"
" filetype plugin on
" ~/.vim/plugin/<filetype>.vim
" 针对不同类型文件分别加载不同的配置文件，例如，html、python 采用不同的缩进
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" --------------
" UltiSnips config
" --------------
" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


" --------------
" my config
" --------------
" show line number
set number

" To use omni completion, type <C-X><C-O> while open in Insert mode.
set omnifunc=syntaxcomplete#Complete


" show cursor's position at right bottom
set ruler

" use mouse everywhere
set mouse=a


" highlight search result
set hls

" deable highlight search result
" set nohls


" Show the command we are typing.
set showcmd


" Set tab label to show tab number, filename, if modified ('+' is shown if the 
" current window in the tab has been modified)
"set guitablabel=%N/\ %t\ %M

" Python
" Execute file being edited with <Shift> + e:
" add -B argument to not generate .pyc file
autocmd FileType python map <buffer> <S-e> :w<CR>:!/usr/bin/env python -B % <CR>

" ---------------------------------------- 
" Golang
" ---------------------------------------- 
" <Shift> + e: Execute golang code
autocmd FileType go map <buffer> <S-e> :w<CR>:!/usr/bin/env go run % <CR>
" format golang code before saving
autocmd FileType go autocmd BufWritePre <buffer> Fmt 

" ---------------------------------------- 
" Javascript 
" ---------------------------------------- 
" <Shift> + e: Execute javascript code with node.js
autocmd FileType javascript map <buffer> <S-e> :w<CR>:!/usr/bin/env node run % <CR>


" MacVim configuration
if has("gui_running")
    " set colorscheme
    colo desert 
    
    " set MacVim font and size, instead of the default
    "set guifont=Bitstream\ Vera\ Sans\ Mono:h13
    set guifont=Monaco:h14

    " 透明背景
    set transparency=10      
endif 


" prompt line for current line 
" set cterm=None to remove the underline
"set cursorline
"highlight CursorLine guibg=lightblue cterm=None ctermbg=lightblue
"set cursorcolumn
"highlight CursorColumn guibg=lightblue cterm=None ctermbg=lightblue


" python doc comment
autocmd FileType python inoremap <buffer> ''' '''<CR>'''<ESC>kA

" python utf-8
autocmd FileType python inoremap <buffer> utf8 # -*- coding: utf-8 -*-

" auto completion for tornado template language
autocmd FileType htmldjango inoremap <buffer> {% {%<SPACE><SPACE>%}<ESC>yyp3liend<ESC>k$2hi

" 醒目注释
inoremap ### <ESC>i#<SPACE><SPACE><ESC>40i-<ESC>o# <CR><ESC>i#<SPACE><SPACE><ESC>40i-<ESC>kA

" HTML comment
" details:
" * tornado 模板会被认定为 htmldjango
" * 使用 <buffer> 参数，防止影响到其他类型的文件
" * 参考： http://stackoverflow.com/questions/8825032/vim-inoremap-for-specific-filetypes
autocmd FileType html,htmldjango inoremap <buffer> --- <!--<SPACE><SPACE>--><ESC>3hi

autocmd FileType html,htmldjango inoremap <buffer> script <script type="text/javascript" src=""></script> 

autocmd FileType javascript inoremap <buffer> /** /**<CR><CR>/<ESC>kA<SPACE>
autocmd FileType sh inoremap <buffer> if if<SPACE>;<SPACE>then<ESC>o<ESC>ifi<ESC>kf;i


" ---------------------------------------- 
" 代码模版
" ---------------------------------------- 
inoremap pytemp <ESC>:r ~/Templates/pymain.template<CR>kdd
inoremap ctemp <ESC>:r ~/Templates/cmain.template<CR>kdd
inoremap bashtemp <ESC>:r ~/Templates/bash.template<CR>kdd
inoremap pylog <ESC>:r ~/Templates/pylog.template<CR>kdd
inoremap jsajax <ESC>:r ~/Templates/js_ajax.template<CR>kdd
autocmd BufNewFile *.py 0r ~/Templates/pymain.template
autocmd BufNewFile *.sql 0r ~/Templates/sql.template
autocmd BufNewFile *.c 0r ~/Templates/cmain.template
autocmd BufNewFile *.sh 0r ~/Templates/bash.template
autocmd BufNewFile *.java 0r ~/Templates/javamain.template
autocmd BufNewFile *.html 0r ~/Templates/html5.template
autocmd BufNewFile *.go 0r ~/Templates/go.template
autocmd BufNewFile *.rsync 0r ~/Templates/rsync.template
autocmd BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} 0r ~/Templates/markdown.template


" ---------------------------------------- 
" 缩写 （abbreviations)
" :abbreviate: Abbreviations for all modes
" :iabbrev: Abbreviations for the insert mode
" :cabbrev: Abbreviations for the command line only
" ---------------------------------------- 
" 快速输入 %Y-%m-%d %H-%M-%S
iabbrev ymd "%Y-%m-%d %H:%M:%S"


" ---------------------------------------- 
" key bingdings
" :map: For the Normal, Insert, Visual, and Command-line modes
" :imap: For the Insert mode only
" :cmap: For the Command-line mode only
" :nmap: For the Normal mode only
" :vmap: For the Visual mode only
" ---------------------------------------- 
map h1 yypVr=o
map h2 yypVr-o
map h3 I-<ESC>A-<ESC>o


"command! -range FmtTable python FmtTable(<f-line1>,<f-line2>,"table","|") 
"" User <f-args> to quotes each arguments individually, so not use <args>
"command! -range -nargs=1 FmtAssign python FmtTable(<f-line1>,<f-line2>,"assign",<f-args>) 
"" :py FmtTable(1, 10)
"python << EOS
"def FmtTable(line1, line2, format_type, separator="|"): 
"    '''
"    >>> s = u'长度'
"    >>> len(s)
"    2
"    >>> len(s.encode("utf-8"))
"    6
"    >>> len(s.encode("gbk"))
"    4
"    '''
"    import vim
"    import string 
"    input_separator = separator 
"    output_separator = separator 
"    line1 = int(line1)
"    line2 = int(line2)
"    selected_lines = vim.current.buffer.range(line1, line2) 
"
"    col_max_lengths = []
"    # first we collect col lengths and calculate the longest 
"    for line in selected_lines[:]: 
"        line = line.decode('utf-8')
"        cols = line.split(input_separator)
"        for i in xrange(len(cols)): 
"            col_length = len(cols[i].encode('gb18030'))
"            try: 
"                if col_length > col_max_lengths[i]: 
"                    col_max_lengths[i] = col_length 
"            except IndexError, err: 
"                col_max_lengths.append(col_length) 
"
"    separator_line = "+".join(
"            '-'*col_max_lengths[i] for i in xrange(len(col_max_lengths)))
"
"    tmp_buffer = [] 
"    if format_type == 'table':
"        tmp_buffer.append(separator_line)
"    # Then we fill the cols with spaces 
"    for line in selected_lines[:]: 
"        line = line.decode('utf-8')
"        cols = line.split(input_separator) 
"        new_line = output_separator.join(
"            [content + " "*(col_max_lengths[i]-len(content.encode("gb18030"))) 
"                for i, content in enumerate(cols)]).encode("utf-8")
"        tmp_buffer.append(new_line) 
"        if format_type == 'table':
"            tmp_buffer.append(separator_line)
"
"    # b.append(list)  Append a list of lines to the buffer
"    # b.append(list, nr)
"    vim.current.buffer.append(tmp_buffer, line2)
"    del selected_lines[:]
"EOS


" Remove trailing whitespace in vim before saving
" 对于新建文件，可能需要重新打开才能识别文件类型(:e)
autocmd FileType c,cpp,python,ruby,java,sh,html,javascript autocmd BufWritePre <buffer> :%s/\s\+$//e


" A tip might be to run the Pyflakes check every time you write a Python file,
" to enable this, add the following line to your .vimrc file
autocmd BufWritePost *.py call Pyflakes()


" format status line
" set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ENCODING=%{&fileencoding}]\ [POS=%04l,%04v]\ [%p%%]\ [LINES=%L]
set statusline=%F%m%r%h%w\ [%{&ff}\ %{&fileencoding}\ %Y]\ [POS=%04l,%04v]
set laststatus=2


" Execute currently selected visual range as Python. Lines are pre-processed
" to remove extra indentation, leaders, or decorators that might be in place
" due to the line range being part of a code block in a markup-language
" document (such as ReStructured Text, Markdown, etc.)
" Usage: Select a range of line in the buffer and then call ':EvalPy' to
" execute those lines in the default system Python and show the results in the
" command window. Using the 'bang' operator (':EvalPy!') will execute the
" lines and insert the results in the current buffer.
" From: http://jeetworks.org/node/146
function! <SID>EvaluateCurrentRangeAsMarkedUpPython(insert_results) range
"" get lines
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lines = getline(lnum1, lnum2)
" let lines[-1] = lines[-1][: col2 - 2]
" let lines[0] = lines[0][col1 - 1:]

"" remove blank rows
    let rows = []
    for line in lines
        let row = substitute(line, '^\s*\(.\{-}\)\s*$', '\1', '')
        if len(row) > 0
            call add(rows, line)
        endif
    endfor
    let lines = rows

    if len(lines) == 0
        return
    endif
    let leader = matchstr(lines[0], '^\s*\(>>>\|\.\.\.\)\{0,1}\s*')
    let leader_len = len(leader)
    let code_lines = []
    for line in lines
        let code_line = strpart(line, leader_len)
        call add(code_lines, code_line)
    endfor
    let code = join(code_lines, "\n")
    if empty(a:insert_results)
        redir => result
        silent execute "!python -c " . shellescape(code)
        redir END
        let rows = split(result, '\n')[1:]
        let result = join(rows, "\n")
        echo result
    else
        let endpos = getpos("'>")
        call setpos('.', endpos)
        execute "r !python -c " . shellescape(code)
    endif
endfunction
command! -bang -range EvalPy :call s:EvaluateCurrentRangeAsMarkedUpPython("<bang>")


" get current file name without extention type
" 以 . 为分割，取第一个段
command! PrintFileBaseName :.!ls % | cut -d . -f 1


" = Fold =
" :help folding
set foldmethod=marker


" http://vim.wikia.com/wiki/Move_to_next/previous_line_with_same_indentation
" Jump to the next or previous line that has the same level or a lower
" level of indentation than the current line.
"
" exclusive (bool): true: Motion is exclusive
" false: Motion is inclusive
" fwd (bool): true: Go to next line
" false: Go to previous line
" lowerlevel (bool): true: Go to line with lower indentation level
" false: Go to line with the same indentation level
" skipblanks (bool): true: Skip blank lines
" false: Don't skip blank lines
function! NextIndent(exclusive, fwd, lowerlevel, skipblanks)
  let line = line('.')
  let column = col('.')
  let lastline = line('$')
  let indent = indent(line)
  let stepvalue = a:fwd ? 1 : -1
  while (line > 0 && line <= lastline)
    let line = line + stepvalue
    if ( ! a:lowerlevel && indent(line) == indent ||
          \ a:lowerlevel && indent(line) < indent)
      if (! a:skipblanks || strlen(getline(line)) > 0)
        if (a:exclusive)
          let line = line - stepvalue
        endif
        exe line
        exe "normal " column . "|"
        return
      endif
    endif
  endwhile
endfunction

" Moving back and forth between lines of same or lower indentation.
nnoremap <silent> [l :call NextIndent(0, 0, 0, 1)<CR>
nnoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>
nnoremap <silent> [L :call NextIndent(0, 0, 1, 1)<CR>
nnoremap <silent> ]L :call NextIndent(0, 1, 1, 1)<CR>
vnoremap <silent> [l <Esc>:call NextIndent(0, 0, 0, 1)<CR>m'gv''
vnoremap <silent> ]l <Esc>:call NextIndent(0, 1, 0, 1)<CR>m'gv''
vnoremap <silent> [L <Esc>:call NextIndent(0, 0, 1, 1)<CR>m'gv''
vnoremap <silent> ]L <Esc>:call NextIndent(0, 1, 1, 1)<CR>m'gv''
onoremap <silent> [l :call NextIndent(0, 0, 0, 1)<CR>
onoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>
onoremap <silent> [L :call NextIndent(1, 0, 1, 1)<CR>
onoremap <silent> ]L :call NextIndent(1, 1, 1, 1)<CR>


let Tlist_Ctags_Cmd = "/usr/local/bin/ctags"
let Tlist_Use_Right_Window = 1


" Vimwiki
" 解决与 ibus 拼音输入法的冲突
autocmd FileType vimwiki noremap <C-S-Space> <C-Space>

autocmd FileType vimwiki map <buffer> <S-e> :Vimwiki2HTMLBrowse <CR>

" 解决 markdown 文件识别为 vimwiki 的问题
let g:vimwiki_ext2syntax = {}


" UI language
if has('unix')
    language messages C
else
    language messages en
endif


" Vimwiki
let g:vimwiki_list = [{'path': '~/vimwiki/',
  \ 'path_html': '~/work/vimwiki_html/',
  \ 'css_name': 'style.css',
  \ 'template_path': '~/vimwiki/',
  \ 'template_default': 'templates/vimwiki_default_template',
  \ 'template_ext': '.html'}]

let g:vimwiki_diary_months = {
      \ 1: '一月', 2: '二月', 3: '三月', 
      \ 4: '四月', 5: '五月', 6: '六月',
      \ 7: '七月', 8: '八月', 9: '九月',
      \ 10: '十月', 11: '十一月', 12: '十二月'
      \ }

" then we can write <div class="test"></div> in wiki
let g:vimwiki_valid_html_tags="div,script,style,ul,li,iframe,img"


" ---------------------------------------- 
" User defined commands must start with an uppercase letter
" ---------------------------------------- 
command Sudow execute "w !sudo tee % > /dev/null"
command Table execute "VimwikiTable"
command TableLeft execute "VimwikiTableMoveColumnLeft"
command TableRight execute "VimwikiTableMoveColumnRight"

let g:vim_markdown_folding_disabled=1

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" " Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


" 自动填充 Markdown 模板变量
function! TemplateSlugSubstitutions()
	exe "normal gg"
	let date = system("date '+%Y-%m-%d %H:%M:%S'")
	let date = strpart(date, 0, strlen(date) - 1)
	" get file name without extension
	let slug = expand("%:r")
	exe "silent! :1,$s/#SLUG_DATE/".date."/g"
	exe "silent! :1,$s/Modified:\ .*/Modified:\ ".date."/g"
	exe "silent! :1,$s/#SLUG_URL/".slug."/g"
endfunction

autocmd FileType md,mdown,mkd,mkdn,markdown,mdwn map <buffer> <S-e> :call TemplateSlugSubstitutions() <CR>
