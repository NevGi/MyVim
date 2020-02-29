set nocompatible              " required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Lokaltog/vim-powerline'
Plugin 'Lokaltog/vim-easymotion' 
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'derekwyatt/vim-fswitch'
Plugin 'derekwyatt/vim-protodef'
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'suan/vim-instant-markdown'
Plugin 'dyng/ctrlsf.vim'
Plugin '907th/vim-auto-save'

" ctags 自动更新插件
Plugin 'vim-scripts/indexer.tar.gz'
Plugin 'vim-scripts/DfrankUtil'
Plugin 'vim-scripts/vimprj'

let g:indexer_ctagsCommandLineOptions="-R --c++-kinds=+p+l+x+c+d+e+f+g+m+n+s+t+u+v --fields=+liaS --extra=+q --language-force=c++"

call vundle#end()            " required
filetype plugin indent on


" NEDTREE
nmap <F2> :NERDTreeToggle<CR>
" 只显示1
let NERDTreeShowLineNumbers=1
let NERDTreeAutoCenter=1
" ?Ƿ???ʾ?????ļ?
let NERDTreeShowHidden=1
" 宽度
let NERDTreeWinSize=35
" 打开时显示
let g:nerdtree_tabs_open_on_console_startup=1
" 不显示下面文件
let NERDTreeIgnore=['\.pyc','\~$','\.swp']
" 显示标签
let NERDTreeShowBookmarks=1

" Tagbar
let g:tagbar_width=35
let g:tagbar_autofocus=1
let g:tagbar_left = 0
autocmd BufReadPost *.cpp,*.[ch],*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()
nmap <F3> :TagbarToggle<CR>

" ctrlp 
let g:ctrlp_map = '<leader>ff' " 搜索文件
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:vtrlp_math_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1


" powerline
let g:Powerline_sysmbol = 'fancy'
set encoding=utf-8
set laststatus=2


" protodef
let g:protodefprotogetter='~/.vim/bundle/vim-protodef/pullproto.pl'
" ??Ա??????ʵ??˳????????˳??һ??
let g:disable_protodef_sorting=1



" YouComplete
let g:ycm_global_ycm_extra_conf='~/.vim/bundle/youcompleteme/third_party/ycmd/.ycm_extra_conf.py'

highlight PmenuSel ctermfg=2 ctermbg=3 guifg=#AFD700 guibg=#106900
let g:ycm_complete_in_comments=1
let g:ycm_confirm_extra_conf=0
let g:ycm_collect_identifiers_from_tags_files=1
let g:ycm_min_num_of_chars_for_completion=1
let g:ycm_confirm_extra_conf=0
let g:ycm_cache_omnifunc=0
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_server_python_interpreter='/usr/bin/python3'
let g:ycm_autoclose_preview_window_after_completion=1
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

let OmniCpp_defaultNamespaces = ["_GLIBCXX_STD"]
set tags+=/usr/include/c++/9/stdcpp.tags
set tags+=/usr/include/sys.tags
set tags+=/usr/local/include/local.tags


"snippet 模板补全
let g:UltiSnipsSnippetDirectories=["mysnippets"]
let g:UltiSnipsExpandTrigger="<leader><tab>"
let g:UltiSnipsJumpForwardTrigger="<leader><tab>"
let g:UltiSnipsJumpBackwardTrigger="<leader><s-tab>"


"markdown
let g:instant_markdown_autostart=0
map <F8> :InstantMarkdownPreview<CR>


"auto save
let g:auto_save = 1
let g:auto_save_events=["InsertLeave", "TextChanged"]
" "TextChangedI", "CursorHoldI", "CompleteDone"]
"set updatetime=5000
"python
map <F5> :w<CR> :!python3 %<CR>

au BufNewFile,BufRead *.py "????py?ļ?֧??PEP8????

autocmd BufNewFile *.py 0r ~/.vim/vim_template/vim_python_header  
autocmd BufNewFile *.py ks|call FileName()|'s  
autocmd BufNewFile *.py ks|call CreatedTime()|'s  

fun FileName()  
    if line("$") > 10
        let l = 10  
    else
        let l =line("$")
    endif
    exe "1,".l."g/File Name:.*/s/File Name:.*/File Name:".expand("%")
endfun

fun CreatedTime()
    if line("$") > 10
        let l=10
    else
        let l=line("$")
    endif
    exe "1,".l."g/Created Time:.*/s/Created Time:.*/Created Time:".strftime("%Y-%m-%d %T")
endfun



" 给c cpp java文件输入格式
autocmd BufNewFile *.[ch],*.cpp,*.hpp,*.sh,*.java exec ":call SetTitle()" 
func SetTitle() 
    if &filetype == 'sh'
        call setline(1,"\#########################################################################") 
        call append(line("."), "\# File Name: ".expand("%")) 
        call append(line(".")+1, "\# Author: kzh") 
        call append(line(".")+2, "\# mail: 2471604619@qq.com") 
        call append(line(".")+3, "\# Created Time: ".strftime("%c")) 
        call append(line(".")+4, "\#########################################################################") 
        call append(line(".")+5, "\#!/bin/bash") 
        call append(line(".")+6, "") 
    else
        call setline(1,"/**") 
        call append(line("."), " * @file ".expand("%")) 
        call append(line(".")+1, " * @brief ") 
        call append(line(".")+2, " * @details")
        call append(line(".")+3, " * @mainpage")
        call append(line(".")+4, " * @author kzh")
        call append(line(".")+5, " * @email 2471604619@qq.com")
        call append(line(".")+6, " * @version 1.0.0")
        call append(line(".")+7, " * @date ".strftime("%c")) 
        call append(line(".")+8, " */") 
    endif

"    if &filetype == 'cpp'
"        call append(line(".")+9, "#include<iostream>")
"        call append(line(".")+10, "using namespace std;")
"        call append(line(".")+11, "") 
"        call append(line(".")+12, "")
"        call append(line(".")+13, "int main()") 
"        call append(line(".")+14, "{")
"        call append(line(".")+15, "")
"        call append(line(".")+16, "") 
"        call append(line(".")+17, "    return 0;")
"        call append(line(".")+18, "}")
"    endif
"    if &filetype == 'c'
"        call append(line(".")+9, "#include<stdio.h>")
"        call append(line(".")+10, "")
"        call append(line(".")+11, "") 
"        call append(line(".")+12, "")
"        call append(line(".")+13, "int main()") 
"        call append(line(".")+14, "{")
"        call append(line(".")+15, "")
"        call append(line(".")+16, "")
"        call append(line(".")+17, "    return 0;")
"        call append(line(".")+18, "}")
"    endif 
    autocmd BufNewFile * normal G
endfunc 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"????????
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


let mapleader=";"
syntax enable
set number
set nowrap
set helplang=cn
set norelativenumber
set showcmd
set history=500
set autoread
set autochdir
set hlsearch
set incsearch
"set ignorecase
set backspace=2
set ruler
set wildmenu
set mouse=a
" 让鼠标右键可用
if has('mouse')
    set mouse-=a
endif



set showmatch
set cursorline


set nobackup

set expandtab
set autoindent
set smartindent
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
"python

set textwidth=79


"折叠
set foldmethod=indent "syntax
set nofoldenable


map <leader>s :w<CR>
map <leader>q :q<CR>
map <leader>Q :q!<CR>
map <leader>S :w!<CR>
map <leader>r :source $MYVIMRC<CR>

map <leader><CR> :noh<CR>

map sl :set splitright<CR>:vsplit<CR> 
map sh :set nosplitright<CR>:vsplit<CR>
map sj :set splitbelow<CR>:split<CR>
map sk :set nosplitbelow<CR>:split<CR>

map <leader>j <C-W>j
map <leader>h <C-W>h
map <leader>k <C-W>k
map <leader>l <C-W>l 

map <up> :res +5<CR>
map <down> :res -5<CR>
map <left> :vertical resize-5<CR>
map <right> :vertical resize+5<CR>

map te :tabe<CR>
map tn :-tabnext<CR>
map tf :+tabnext<CR>

map <leader>sv <C-W>t<C-H>H
map <leader>sh <C-W>t<C-W>K


map <leader>sw :FSHere<CR>
" 自动生成实现
map <leader>d <leader>PP


map <leader><leader>jc :YcmCompleter GoToDeclaration<CR>
map <leader><leader>jd :YcmCompleter GoToDefinition<CR>
map <leader>jd <C-]>
map <leader>jf <C-T>
map <leader>jp <C-O>

" 打开最近使用文件
map <leader>fp :CtrlPMRU<CR> 

" search in project
" 显示匹配的上下文 选中其中匹配项 按下p 显示文件具体内容
map <leader>sp :CtrlSF<CR> 

" 多选光标 shift+n 选中下一个 shift+k 跳过这个
let g:multi_cursor_next_key='<S-n>'
let g:multi_cursor_skip_key='<S-k>'

"?۵?
map zo zo
map zc zc
map ZO zR
map ZC zM
" set tags+=/home/trators/Code/DbUtil/tags
" set tags+=/home/trators/Code/DbUtil/oci/oci.tags
"set tags+=/home/trators/OthLib/AndroidAuthService/include/tags

" 自动匹配 ctl+p 向上 ctl+n 向下
" <leader><leader>字符 插件 vim-easymotion 匹配字符 然后 改为a b c d 由你跳转
