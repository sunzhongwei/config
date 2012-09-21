" 常用命令
" &. 重新加载 vim 配置文件
" ========================
" :so ~/.vimrc
" so is short for source
"
" plugin layout in .vim directory
" http://learnvimscriptthehardway.stevelosh.com/chapters/42.html
"
" &. vi command pattern
" =====================
" (command)(number)(text object)
" 等同于
" (number)(command)(text object)
" 第一种写法，读起来顺口; 但是有时候只能用第二种写法，例如：50i-<ESC>
"
" &. NERDTree
" ===========
" enable help doc
"    :helptags ~/.vim/doc
" show help
"    :help NERDTree
" use NERDTree
"    :NERDTree
"
" &. taglist 
" ==========
" http://www.vim.org/scripts/script.php?script_id=273
" 由于 taglist 依赖于 Exuberant Ctags，而 Mac OS 下的 ctags 是 UNIX ctags。
" 所以需要手动安装 Exuberant Ctags.
" ./configure && make && sudo make install
" 然后修改 .vimrc , 加入下面的配置
" let Tlist_Ctags_Cmd="/usr/local/bin/ctags"
" 
" show help
" 	:help :TlistToggle
" use taglist
"	:TlistToggle
"
" Paste registers in search or colon commands instead of using the clipboard
" ==========================================================================
" You can type Ctrl-R to insert a register when in insert mode, or when typing
" in the command or search line.
" 在 insert mode, 或者输入 vim 命令，搜索时，如果输入 <C-r> 会看到一个 "
" 提示，这时只需要输入对应的 register 标识，就能进行粘帖, 例如，a。
" 输入 " 对应 unnamed register.
" 在命令模式下，可以通过 <C-r><C-w> 来快速粘帖当前光标所在位置的单词。
"
" &. include-search for c programming
" ===================================
" Vim knows about include files, and can search them for a word you are
" looking for. The most common action is to lookup the prototype of a
" function. Position the cursor on the name of the function in your file and
" type [I: Vim will show a list of all matches for the function name in
" included files.
" 其他相关命令参见：help include-search
"
" &. format json string in VIM
" ============================ 
" :%!python -m json.tool 
" 这里的 % 和查找替换时的作用一样，指选中 buffer 中的所有行。
" 所以，可以在写程序注释时，这样使用：
" 先输入一整行 json，为了快速输入，首次输入时，不进行排版
" {"1": "http://...", "2": "http://...", "3": "http://..."}
" 然后使用 <C-v> 选中这行，输入 :!python -m json.tool 
"
" &. 使用 :vimgrep + :cope 在 VIM 中遍历 grep 的搜索结果 
" ======================================================
" 例如我要遍历搜索所有包含 RequestHandler 的代码
" 1. 新建一个 tab 页，否则搜索结果会覆盖掉当前窗口中的内容
" :tabnew 
" 2. 搜索, 当前窗口显示的是包含匹配的整个文件内容
" :vimgrep RequestHandler **/*.py
" 3. 显示所有匹配的列表
" :cope
"
" &. convert dos format to unix format
" ====================================
" set ff=unix
" 不转换格式带来的问题, 例如将一个 python 文件加上可执行权限，执行时会报错：
" env: python\r: No such file or directory
" 因为 dos format 是用 \r\n 做换行
"
" &. Auto format pasted code
" ==========================
" 我们从网上复制代码到 VIM 的时候，会变成逐行缩进的格式。那是因为每个换行都被
" 处理成了新的缩进。进入 paste-mode 就能避免这种问题。
" :set paste
" 粘帖，之后推出 paste-mode.
" :set nopaste
"
" &. 正则匹配中的特殊字符
" =======================
" http://vim.wikia.com/wiki/Search_and_replace
"
" &. 查找替换前进行确认 (confirm)
" :%s/python/ipython/gc
" 
" &. Moves the cursor to the character marked by x.
" =================================================
" `x 
" 'x : Moves the cursor to the first character of the line marked by x.
"
" &. Joining Two Lines
" ====================
" J
"
" &. write with sudo
" ==================
" :w !sudo tee % > /dev/null
" http://stackoverflow.com/questions/2600783/how-does-the-vim-write-with-sudo-trick-work
"
" &. vim 中切换 panes
" ===================
" Ctrl-w h,j,k,l
"
" &. 移动到匹配的括号，以及C语言的注释 /* */, 
" ===========================================
" 以及 preprocessor conditional: #if, #ifdef, #else, #elif, #endif.
" TODO: 增加对模版语言及HTML标签的支持
" %
"
" &. 数字自增列操作
" =================
" 实现一：
" 将一列数字全部自增一，例如原来是从 0 开始的，改为 1 开始
" Ctrl-a 是光标处数字的自增，qa 录制一下, 每行执行一下即可。
" 若要生产一列自增数字 N 行, 从 1 开始
" 1 qa yy p Ctrl-a q <N>@a
" 自减是 Ctrl-x
" 实现二(vimscript)：
" :for i in range(1, 10)|put =i|endfor
" :for i in range(1, 10)|put ='current num is: '.i|endfor
"
" &. Line complete
" ================
" Ctrl-x Ctrl-l
"
" &. 更改 vim 的工作目录
" ======================
" cd <dir>
"
" &. change word
" ==============
" cw: To the end of a word
" c2b: Back 2 words
" c$: To the end of line
" c0: To the beginnging of line
" c2w: change 2 words
" cc: Change one line. (类似的：yy, dd)


set nocompatible   	" For vimwiki
syntax on

" set fileformat=mac

" make sure there is no more than 80 characters one line
" disable this, because it's conflict with set number.
" set columns=80

" yy 就可以复制到系统剪切板
set clipboard+=unnamed

" show line number
set number
" set nonumber


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
filetype indent on

" ~/.vim/plugin/<filetype>.vim
" 针对不同类型文件分别加载不同的配置文件，例如，html、python 采用不同的缩进
filetype plugin on


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

" Execute file being edited with <Shift> + e:
" add -B argument to not generate .pyc file
map <buffer> <S-e> :w<CR>:!/usr/bin/env python -B % <CR>

" set colorscheme
colo elflord
"colo zellner
"colo torte mm
"colo macvim

" prompt line for current line 
" set cterm=None to remove the underline
"set cursorline
"highlight CursorLine guibg=lightblue cterm=None ctermbg=lightblue
"set cursorcolumn
"highlight CursorColumn guibg=lightblue cterm=None ctermbg=lightblue

" type 'za' to open and close a fold inside a method
"set foldmethod=indent
"set foldlevel=99

" set MacVim font and size, instead of the default
"set guifont=Bitstream\ Vera\ Sans\ Mono:h13
set guifont=Monaco:h12

" python doc comment
inoremap ''' '''<CR>'''<ESC>kA

" auto completion for tornado template language
inoremap {% {%<SPACE><SPACE>%}<ESC>yyp3liend<ESC>k$2hi

" 醒目注释
inoremap ### <ESC>i#<SPACE><SPACE><ESC>40i-<ESC>o# <CR><ESC>i#<SPACE><SPACE><ESC>40i-<ESC>kA

" ---------------------------------------- 
" 代码模版
" ---------------------------------------- 
inoremap pytemp <ESC>:r ~/Templates/pymain.template<CR>kdd
inoremap ctemp <ESC>:r ~/Templates/cmain.template<CR>kdd
inoremap bashtemp <ESC>:r ~/Templates/bash.template<CR>kdd
inoremap pylog <ESC>:r ~/Templates/pylog.template<CR>kdd
autocmd BufNewFile *.py 0r ~/Templates/pymain.template
autocmd BufNewFile *.c 0r ~/Templates/cmain.template
autocmd BufNewFile *.sh 0r ~/Templates/bash.template
autocmd BufNewFile *.java 0r ~/Templates/javamain.template
autocmd BufNewFile *.html 0r ~/Templates/html5.template


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
autocmd FileType c,cpp,python,ruby,java,sh,html autocmd BufWritePre <buffer> :%s/\s\+$//e


" A tip might be to run the Pyflakes check every time you write a Python file,
" to enable this, add the following line to your .vimrc file
autocmd BufWritePost *.py call Pyflakes()


" format status line
" set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ENCODING=%{&fileencoding}]\ [POS=%04l,%04v]\ [%p%%]\ [LINES=%L]
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ENCODING=%{&fileencoding}]\ [POS=%04l,%04v]\ [LINES=%L]
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

