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
Plugin 'bling/vim-airline' " airline status bar
Plugin 'christoomey/vim-tmux-navigator' " vim/tmux window navigation
Plugin 'docunext/closetag.vim' " close HTML tags with C-_
Plugin 'editorconfig/editorconfig-vim' " EditorConfig support
Plugin 'FooSoft/vim-argwrap' " wrap/unwrap arguments
Plugin 'garbas/vim-snipmate' " snippets support
Plugin 'gregsexton/MatchTag' " Matches HTML tags
Plugin 'jacquesbh/vim-showmarks' " show marks
Plugin 'kien/ctrlp.vim' " CtrlP
Plugin 'Lokaltog/vim-easymotion' " EasyMotion
Plugin 'maksimr/vim-jsbeautify' " JS beautify
Plugin 'MarcWeber/vim-addon-mw-utils' " required for SnipMate
Plugin 'nathanaelkane/vim-indent-guides' " adds indent guides - toggle with <Leader>ig
Plugin 'othree/html5.vim' " html5 syntax highlighting
Plugin 'pangloss/vim-javascript' " javascript syntax highlighting
Plugin 'Raimondi/delimitMate' " adds matching end brackets
Plugin 'rizzatti/dash.vim' " dash integration
Plugin 'scrooloose/nerdcommenter' " easy comments
Plugin 'scrooloose/syntastic' " Syntastic - Linter
Plugin 'shawncplus/phpcomplete.vim' " Better PHP completions
Plugin 'Shougo/neocomplcache.vim' " code completion
Plugin 'sjl/gundo.vim' " undo browsing
Plugin 'StanAngeloff/php.vim' " Better PHP syntax highlighting
Plugin 'taglist.vim' " taglist
Plugin 'terryma/vim-multiple-cursors' " multiple cursors
Plugin 'tomtom/tlib_vim'  " required for SnipMate
Plugin 'tpope/vim-fugitive' " Git support
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

" Don't redraw while executing macros (good performance config)
set lazyredraw

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
nmap <leader>q :lcl<CR>:bd<CR>
nmap <Leader>Q :bd *<C-a><CR>

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
set wrap "Wrap lines
set number " line numbers

" Backspace navigation
set backspace=indent,eol,start

" Use OS clipboard
set clipboard=unnamed

" Hide rather than close buffers
set hidden

" undo/command history
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set undofile " store undos between sessions
set undodir=~/.vim/undo " location to store undo history

" auto apply Vim settings
if has("autocmd")
    augroup reload_vimrc " {
        autocmd!
        autocmd BufWritePost $MYVIMRC source $MYVIMRC
    augroup END " }
endif

" skeleton files 
if has("autocmd")
    autocmd BufNewFile index.html 0r ~/.vim/skeleton/index.html
    autocmd BufNewFile *.js 0r ~/.vim/skeleton/umd.js
    autocmd BufNewFile *.php 0r ~/.vim/skeleton/class.php
endif

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
inoremap ,, <End>,
nnoremap ,, A,<Esc>

" turn on file type specific indentation
filetype indent on

" backups
set backupdir=~/.vim/tmp
set directory=~/.vim/tmp

" filetypes
" Only do this part when compiled with support for autocommands
if has("autocmd")
    " Enable file type detection
    filetype on

    " Syntax of these languages is fussy over tabs/spaces
    autocmd FileType make setlocal ts=4 sts=4 sw=4 noexpandtab
    autocmd FileType yml setlocal ts=2 sts=2 sw=2

    " Treat .make files as Makefile
    autocmd BufNewFile,BufRead *.make setfiletype make
    autocmd BufNewFile,BufRead *.yaml setfiletype yml
endif


" =============
" Plugin Config
" =============

" fugitive
nnoremap å :Gwrite<CR>
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
let g:ctrlp_custom_ignore = { 'dir':  '\v[\/](\.git|vendor|node_modules|build)$', 'file': '\v\.(css)$' }
map <c-o> :CtrlPBuffer<CR>
let g:ctrlp_match_window = 'bottom,order:ttb'

if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

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

" dash integration
nmap <silent> <leader>d <Plug>DashSearch
let g:dash_map = { 'php' : ['php', 'l'], 'javascript': ['ld', 'js'], 'scss': ['css'] }

" argwrap
nnoremap <silent> <leader>a :ArgWrap<CR>

" snipmate
imap <expr>.. "\<Plug>snipMateNextOrTrigger"

" JS Beautify
map <C-f> :call JsBeautify()<CR>

" Solarized
syntax enable
set background=dark
colorscheme solarized
highlight clear SignColumn
call gitgutter#highlight#define_highlights()
