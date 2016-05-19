autocmd FileType c,h,cpp,c++,cxx,gob,cs set cindent
autocmd FileType sgml,html              set shiftwidth=2 tabstop=2

syntax   on
filetype on

au! BufNewFile,BufRead *.gob set filetype=cpp
au! BufNewFile,BufRead *.less set filetype=css
au! BufNewFile,BufRead *.rb set tabstop=2 shiftwidth=2
au! BufNewFile,BufRead *.erb set filetype=ruby tabstop=2 shiftwidth=2
au! BufNewFile,BufRead *.rake set filetype=ruby tabstop=2 shiftwidth=2
au! BufNewFile,BufRead *.jbuilder set filetype=ruby tabstop=2 shiftwidth=2
au! BufNewFile,BufRead *.yml set tabstop=2 shiftwidth=2
au! BufNewFile,BufRead *.m set tabstop=2 shiftwidth=2
au! BufNewFile,BufRead *.pp set tabstop=2 shiftwidth=2
au! BufNewFile,BufRead *.scss set tabstop=2 shiftwidth=2
au! BufNewFile,BufRead *.js set tabstop=2 shiftwidth=2
au! BufNewFile,BufRead *.tf set tabstop=2 shiftwidth=2

set nocompatible
set ruler
set showcmd
set incsearch
set hlsearch
set tabstop=4
set shiftwidth=4
set backspace=2
set scrolloff=4
set autoindent
set expandtab
set sm
set vb
set tags=tags;/
set directory=~/.vim/swap

map <C-J> zzjzz
map <C-K> zzkzz
nnoremap <C-S> :execute 'below new' RSpecPath(@%)<CR>

function! RSpecPath(path)
    let l:spec_path = a:path
    let l:spec_path = substitute(l:spec_path, 'app', 'spec', '')
    let l:spec_path = substitute(l:spec_path, '.rb', '_spec.rb', '')
    let l:spec_path = substitute(l:spec_path, '.jbuilder', '.jbuilder_spec.rb', '')

    return l:spec_path
endfunction

if has("gui")
    colorscheme evening
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guifont=Menlo:h14
    set lines=24 columns=80
endif
