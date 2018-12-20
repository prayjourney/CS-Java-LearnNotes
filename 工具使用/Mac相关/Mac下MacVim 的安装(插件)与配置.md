###  Mac下MacVim 的安装(插件)与配置
***

#### 安装 MacVim

##### step 1
[http://macvim-dev.github.io/macvim/](https://link.jianshu.com/?t=http://macvim-dev.github.io/macvim/)
[https://github.com/macvim-dev/macvim/releases](https://link.jianshu.com/?t=https://github.com/macvim-dev/macvim/releases)
从以上两个地址下载 MacVim 的最新安装包

##### step 2
下载好安装包后解压 将 MacVim.app 拖拽至 Application 目录下

##### step 3
启动 MacVim 在命令模式下输入: h mvim, 获得关于 mvim 的信息, 并根据提示信息将 mvim 文件拷贝到 /usr/bin 目录中, 这样就可以在 Terminal 中使用 mvim 命令打开 MacVim.
```shell
$ cd h:mvim 提示的mvim 所在路径
$ sudo cp -f mvim /usr/bin/
```
> 有时候在完成 mvim 文件的拷贝后还是不能在 Terminal 中使用 mvim 命令启动 MacVim, 这个时候可以打开 mvim 文件 直接修改路径, 指向 Application 目录下的MacVim.app.



##### 配置 MacVim
在安装成功后, 在 "~" 目录下创建 .vimrc 文件, 之后打开该文件进行配置文件编辑, 以下是我个人的配置文件信息

```ruby
"------------------------------------------------------------------------------

" Vundle

"------------------------------------------------------------------------------

" set the runtime path to include Vundle and initialize
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'flazz/vim-colorschemes'

"""""""" vim scripts """"""""""""""""""
Plugin 'vim-scripts/taglist.vim'
Plugin 'vim-scripts/c.vim'
Plugin 'vim-scripts/minibufexpl.vim'
Plugin 'vim-scripts/comments.vim'
Plugin 'vim-scripts/winmanager'

"""""""" git script """""""""""""""""""
Plugin 'scrooloose/nerdtree'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'Lokaltog/vim-powerline'

" All of your Plugins must be added before the following line
call vundle#end()            " required
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


"------------------------------------------------------------------------------

" nerdtree settings

"------------------------------------------------------------------------------
"autocmd vimenter * NERDTree
map <F2> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <silent> <F2> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"------------------------------------------------------------------------------

" ctags settings

"------------------------------------------------------------------------------
let Tlist_Ctags_Cmd ='/usr/local/Cellar/ctags/5.8_1/bin/ctags'

"let g:molokai_original = 1
"let g:rehash256 = 1
"colorscheme molokai

"------------------------------------------------------------------------------

" syntastic setting

"------------------------------------------------------------------------------
let g:syntastic_check_on_open = 1
let g:syntastic_lua_checkers = ['lua', 'luac']

"------------------------------------------------------------------------------

" Powerline setting

"------------------------------------------------------------------------------
set laststatus=2
let g:Powerline_symbols='unicode'

"set foldenable
"set foldnestmax=1
"set foldmethod=syntax

"------------------------------------------------------------------------------

" YouCompleteMe setting

"------------------------------------------------------------------------------

let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

"let g:ycm_error_symbol = '>>'
"let g:ycm_warning_symbol = '>*'
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nmap <F4> :YcmDiags<CR>

set completeopt=longest,menu
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"

inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_confirm_extra_conf=0
let g:ycm_collect_identifiers_from_tags_files=1
let g:ycm_min_num_of_chars_for_completion=2
let g:ycm_cache_omnifunc=0
let g:ycm_seed_identifiers_with_syntax=1
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
"force recomile with syntastic
inoremap <leader><leader> <C-x><C-o>
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 0

"------------------------------------------------------------------------------

" TagList :Tlist

"------------------------------------------------------------------------------
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Ctags_Cmd="/usr/bin/ctags"

"------------------------------------------------------------------------------

" WinManager Setting

"------------------------------------------------------------------------------
let g:winManagerWindowLayout='NERDTree|TagList'
let g:winManagerWidth=30
"let g:AutoOpenWinManager = 1
nmap wm :WMToggle<cr>

"------------------------------------------------------------------------------

" settings

"------------------------------------------------------------------------------
set nocompatible            " be iMproved, required
filetype off                " required

" Set syntax highlighting for specific file types
autocmd BufRead,BufNewFile *.md set filetype=markdown

" color scheme
colorscheme molokai


" Backspace deletes like most programs in insert mode
set backspace=2
" Show the cursor position all the time
set ruler
" Display incomplete commands
set showcmd
" Set fileencodings
set fileencodings=ucs-bom,utf-8,cp936,gb2312,gb18030,big5
set background=dark
set encoding=utf-8
set fenc=utf-8
set smartindent
set autoindent
set cul
set linespace=2
set showmatch
set lines=47 columns=90
set transparency=7

" Numbers
set number
"set numberwidth=5

" font and size
"set guifont=Andale Mono:h14
"set guifont=Monaco:h11
set guifont=Menlo:h14

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set softtabstop=2
set expandtab
set smarttab

" Display extra whitespace
"set list listchars=tab:»·,trail:·
"set list listchars=tab:-·,trail:·

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Highlight current line
au WinLeave * set nocursorline
au WinEnter * set cursorline
set cursorline

if has("gui_running")
    set guioptions-=m
    set guioptions-=T
    set guioptions-=L
    set guioptions-=r
    set guioptions-=b
    set showtabline=0
endif

if has('mouse')
  set mouse=a
endif

if &t_Co > 2 || has("gui_running")
syntax on
endif
```



#####安装插件
如果是首次打开， 则会报错，这是因为没有Vundle插件支持，在配置文件中, 使用了 Vundle 的方式安装插件, 首先需要安装[Vundle](https://github.com/VundleVim/Vundle.vim)，git方式安装 (sudo)
```shell
$ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
之后启动 MacVim, 在命令模式下输入 PluginInstall，就可以自动安装插件了。
> 如果使用 PluginInstall 无法成功安装插件, 可以在执行完 PluginInstall 命令以后按"L"查看安装日志, 获取错误信息. 根据信息中提示的插件最新获取地址.
>
> 进入 bundle/ 目录下
>
> $cd ~/.vim/bundle
> $sudo git clone 插件地址



ref:
1.[macOS Sierra 下 MacVim 的安装与配置 以及插件安装](https://www.jianshu.com/p/2465e07dd59a)




