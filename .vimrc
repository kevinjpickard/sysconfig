set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

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
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.  "Plugin 'ascenator/L9', {'name': 'newL9'}

" Kevin's vim Plugins
" NerdTree
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'dag/vim-fish'
Plugin 'PProvost/vim-ps1'
Plugin 'tpope/vim-surround'
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


source /usr/local/lib/python2.7/*-packages/powerline/bindings/vim/plugin/powerline.vim 
set laststatus=2
set tabstop=2
set softtabstop=0 expandtab
set shiftwidth=2
set smarttab
au Bufread,BufNewFile *.feature set filetype=gherkin
syntax on
set backspace=indent,eol,start
set number

if exists('+colorcolumn')
	set colorcolumn=80
else
	highlight OverLength ctermbg=red ctermfg=white guibg=#592929
	match OverLength /\%>79v.\+/	
endif

autocmd vimenter * NERDTree
let NERDTreeShowHidden=1

" persistent undo
if has("persistent_undo")
    let &undodir='$HOME/backups/vim/vimundo//' " undo files in a folder
    set undofile                         " Save undo history to file
    set undolevels=100000                " Maximum number of undos
    set undoreload=100000                " Save complete files for undo on reload "
endif

" backups
"set backup
"set backupdir=".,$HOME/backups/vim/vimbackups//"
" Ok this isn't cooperating either. Fuck it.
set nobackup
set nowritebackup

" swap files
"let &directory='.,$HOME/backups/vim/swap/'
" Since vim REFUSES to move my swap files, fuck em
set noswapfile

" Open new splits below and to the right
set sb spr

" Syntastic Settings
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
