" =============
" Vundle Config
" =============
set nocompatible              " be improved, required
filetype off                  " required for Vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'airblade/vim-gitgutter' " Gitbar
Plugin 'altercation/vim-colors-solarized' " Solarized Colour Scheme
Plugin 'ap/vim-css-color' " Sets background of Hex colour values
Plugin 'Arkham/vim-quickfixdo' " perform tasks on quickfix list
Plugin 'bling/vim-airline' " airline status bar
Plugin 'christoomey/vim-tmux-navigator' " vim/tmux window navigation
Plugin 'docunext/closetag.vim' " close HTML tags with C-_
Plugin 'editorconfig/editorconfig-vim' " EditorConfig support
Plugin 'embear/vim-localvimrc' " site specific .vimrc files
Plugin 'FooSoft/vim-argwrap' " wrap/unwrap arguments
Plugin 'garbas/vim-snipmate' " snippets support
Plugin 'gregsexton/MatchTag' " Matches HTML tags
Plugin 'jacquesbh/vim-showmarks' " show marks
Plugin 'joonty/vim-phpunitqf.git' " phpUnit
Plugin 'kien/ctrlp.vim' " CtrlP
Plugin 'Lokaltog/vim-easymotion' " EasyMotion
Plugin 'maksimr/vim-jsbeautify' " JS beautify
Plugin 'MarcWeber/vim-addon-mw-utils' " required for SnipMate
Plugin 'nathanaelkane/vim-indent-guides' " adds indent guides - toggle with <Leader>ig
Plugin 'othree/html5.vim' " html5 syntax highlighting
Plugin 'pangloss/vim-javascript' " javascript syntax highlighting
Plugin 'Raimondi/delimitMate' " adds matching end brackets
Plugin 'rizzatti/dash.vim' " dash integration
Plugin 'rking/ag.vim' " ag search
Plugin 'scrooloose/syntastic' " Syntastic - Linter
Plugin 'shawncplus/phpcomplete.vim' " Better PHP completions
Plugin 'Shougo/neocomplcache.vim' " code completion
Plugin 'sjl/gundo.vim' " undo browsing
Plugin 'StanAngeloff/php.vim' " Better PHP syntax highlighting
Plugin 'taglist.vim' " taglist
Plugin 'terryma/vim-multiple-cursors' " multiple cursors
Plugin 'tomtom/tcomment_vim' " smart commenting
Plugin 'tomtom/tlib_vim'  " required for SnipMate
Plugin 'tpope/vim-fugitive' " Git support
Plugin 'tpope/vim-repeat' " better support for repeating motions
Plugin 'tpope/vim-surround' " Surround

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


" ==========
" Vim Config
" ==========

" Disable Ex mode
nnoremap Q <nop>

" turn wildmenu on
set wildmenu

" reload files that are changed
set autoread
au WinEnter * checktime " check for updated file when window changed

" Don't redraw while executing macros (good performance config)
set lazyredraw
set updatetime=4000

" Always show current position
set ruler
set cursorline

" Keep cursor more in middle
set scrolloff=15

" Invisible characters
nmap <leader>l :set list!<CR>
set listchars=tab:▸\ ,eol:¬

" sounds off
set noerrorbells
set novisualbell

" Map \w to close buffer
nmap <leader><Esc> :lcl<CR>:ccl<CR>
nmap <leader>q :lcl<CR>:bd<CR>
nmap <Leader>Q :bd *<C-a><CR><CR>

" preferences
map <Leader>, :e ~/.vimrc<CR>

" save
map <Leader>w :w<CR>

" Highlight search results
set hlsearch
set incsearch
nnoremap <silent> <Leader>/ :nohlsearch<CR> " hide search results with \/

" Set utf8 as standard encoding
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Use spaces instead of tabs
set expandtab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4

set ai "Auto indent
set si "Smart indent
set number " line numbers

" Backspace navigation
set backspace=indent,eol,start

" Use OS clipboard
set clipboard=unnamed

" Hide rather than close buffers
set hidden
" set viminfo^=% " save buffers

" undo/command history
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set undofile " store undos between sessions
set undodir=~/.vim/undo " location to store undo history

" auto apply Vim settings
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" skeleton files 
autocmd BufNewFile index.html 0r ~/.vim/skeleton/index.html
autocmd BufNewFile *.js 0r ~/.vim/skeleton/umd.js
autocmd BufNewFile *.php 0r ~/.vim/skeleton/class.php

" shell options
set shell=/bin/zsh
set guioptions= " remove all guioptions

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Add insert semi-colon shortcut
inoremap ;; <End>;<Esc>
nnoremap ;; A;<Esc>

" Add insert comma shortcut
inoremap ,, <End>,<Esc>
nnoremap ,, A,<Esc>

" turn on file type specific indentation
filetype indent on

" backups
set backupdir=~/.vim/tmp
set directory=~/.vim/tmp

" filetypes
" Only do this part when compiled with support for autocommands
" Enable file type detection
filetype on

" Syntax of these languages is fussy over tabs/spaces
autocmd FileType make setlocal ts=4 sts=4 sw=4 noexpandtab
autocmd FileType yml setlocal ts=2 sts=2 sw=2

" Treat .make files as Makefile
autocmd BufNewFile,BufRead Vagrantfile set filetype=ruby
autocmd BufNewFile,BufRead *.make set filetype=make
autocmd BufNewFile,BufRead *.yaml set filetype=yml

" create file parent directories if they don't exist
if !exists("*s:MkNonExDir")
    function s:MkNonExDir(file, buf)
        if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
            let dir=fnamemodify(a:file, ':h')
            if !isdirectory(dir)
                call mkdir(dir, 'p')
            endif
        endif
    endfunction
endif

augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END


" =============
" Plugin Config
" =============

" fugitive
nnoremap å :Gwrite<CR>
nnoremap ∂ :Gdiff<CR>
nnoremap ç :Gcommit -m ""<Left>
nnoremap Ω :Git checkout %<CR><CR>

" Airline
set laststatus=2
let g:airline_powerline_fonts=1

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_scss_scss_lint_args = "-c ~/.scss-lint.yml" " Set scss-lint config file

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_working_path_mode = 'a'
map <c-o> :CtrlPBuffer<CR>
let g:ctrlp_custom_ignore = { 'dir':  '\v[\/](\.git|vendor|node_modules|build)$', 'file': '\v\.(css)$' }
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_show_hidden = 1

if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -U --hidden -g ""' 

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
endif

" Map K to find word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" neocomplete
let g:neocomplcache_enable_at_startup = 1
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Gundo
nnoremap <Leader>u :GundoToggle<CR>

" show marks
autocmd VimEnter * DoShowMarks!

" show Tags
map <Leader>t :TlistToggle<CR>
let Tlist_Auto_Open=1
let Tlist_Auto_Update=1
let Tlist_Use_Right_Window=1
let Tlist_WinWidth=&columns/3
let tlist_php_settings='php;c:class;f:function' 

" dash integration
nmap <silent> <leader>d <Plug>DashSearch
let g:dash_map = { 'php' : ['php', 'l'], 'javascript': ['ld', 'js'], 'scss': ['css'] }

" argwrap
nnoremap <silent> <leader>a :ArgWrap<CR>

" snipmate
imap <expr>.. "\<Plug>snipMateNextOrTrigger"

" JS Beautify
map <C-f> :call JsBeautify()<CR>

" PHP Unit
let g:phpunit_cmd = "ssh vagrant '(cd /vagrant/ && ./vendor/bin/phpunit)'"

" lvimrc
let g:localvimrc_persistent = 1

" Solarized
syntax enable
set background=dark
colorscheme solarized
highlight clear SignColumn
call gitgutter#highlight#define_highlights()

" Spell check
autocmd FileType markdown,html,txt setlocal spell spelllang=en_gb
:hi SpellBad cterm=underline ctermfg=red

" Highlighting
:highlight TakeNote ctermfg=15 ctermbg=9
:match TakeNote /@TODO\|@BUG\|@FIX/
