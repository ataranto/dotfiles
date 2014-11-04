autocmd FileType c,h,cpp,c++,cxx,gob,cs set cindent
autocmd FileType sgml,html              set shiftwidth=2 tabstop=2

syntax   on
filetype on

au! BufNewFile,BufRead *.gob set filetype=cpp
au! BufNewFile,BufRead *.less set filetype=css
au! BufNewFile,BufRead *.rb set tabstop=2 shiftwidth=2
au! BufNewFile,BufRead *.erb set tabstop=2 shiftwidth=2
au! BufNewFile,BufRead *.jbuilder set tabstop=2 shiftwidth=2
au! BufNewFile,BufRead *.yml set tabstop=2 shiftwidth=2
au! BufNewFile,BufRead *.m set tabstop=2
au! BufNewFile,BufRead *.pp set tabstop=2

set nocompatible

set ruler
set showcmd
set incsearch

set tabstop=4
set shiftwidth=4
set backspace=2
set scrolloff=4
set autoindent
set expandtab
set hlsearch

set sm
set vb

set tags=tags;/

map <C-J> zzjzz
map <C-K> zzkzz

if has("gui_running")
    colorscheme koehler
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guifont=Menlo:h14
    set lines=24 columns=80
endif