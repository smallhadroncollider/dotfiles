set encoding=utf8
scriptencoding utf-8

" auto-install Plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" =======
" Plugins
" =======
call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter' " Gitbar
Plug 'altercation/vim-colors-solarized' " Solarized Colour Scheme
Plug 'bling/vim-airline' " airline status bar
Plug 'christoomey/vim-tmux-navigator' " vim/tmux window navigation
Plug 'editorconfig/editorconfig-vim' " EditorConfig support
Plug 'FooSoft/vim-argwrap', { 'on': 'ArgWrap' } " wrap/unwrap arguments
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim' " distraction free writing
Plug 'mhinz/vim-grepper', { 'on': 'Grepper' }
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'} " code completion
Plug 'qpkorr/vim-bufkill' " keeps splits when killing buffers
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'SirVer/ultisnips'
Plug 'sjl/gundo.vim'
Plug 'terryma/vim-multiple-cursors' " multiple cursors
Plug 'tomtom/tcomment_vim' " smart commenting
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale' " linter

" syntax highlighting
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript' " better javascript
Plug 'raichoo/purescript-vim'
Plug 'xsbeats/vim-blade'

call plug#end()


" ==========
" Vim Config
" ==========

" Disable Ex mode
nnoremap Q <nop>
nnoremap q <nop>

" turn wildmenu on
set wildmenu

" reload files that are changed
set autoread

" Don't redraw while executing macros (good performance config)
set lazyredraw
set updatetime=4000

" only highlight first 200 characters of very long lines
set synmaxcol=500

" Always show current position
set ruler
set cursorline
set cursorcolumn

" sounds off
set noerrorbells
set novisualbell

" Highlight search results
set hlsearch
set incsearch

" Set utf8 as standard encoding
set fileencoding=utf-8

" Use Unix as the standard file type
set fileformats=unix,dos,mac

" Use spaces instead of tabs
set expandtab

" highlight tabs/trailing spaces
set list
set listchars=tab:>-,trail:·
match ErrorMsg '\s\+$'

" highlight smart quotes
match ErrorMsg '[“”]'
match ErrorMsg '@TODO:'

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4

set autoindent "Auto indent
set smartindent "Smart indent
set breakindent " Wordwrap keeps indents

" keep selection when indenting
vnoremap < <gv
vnoremap > >gv

set number " line numbers

" Backspace navigation
set backspace=indent,eol,start

" set intelligent line joins
set formatoptions+=j

" Use OS clipboard
set clipboard=unnamed

" add highlighted column at 120
set colorcolumn=120

" Hide rather than close buffers
set hidden

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

" shell options
set shell=/bin/zsh
set guioptions= " remove all guioptions

" move vertically by visual line and keep things centered
nnoremap j gjzz
nnoremap k gkzz
nnoremap G Gzz
set scrolloff=0


" disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" omni completion
set omnifunc=syntaxcomplete#Complete

" backups
set backupdir=~/.vim/tmp
set directory=~/.vim/tmp

" create file parent directories if they don't exist
if !exists('*s:MkNonExDir')
    function s:MkNonExDir(file, buf)
        if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
            let l:dir=fnamemodify(a:file, ':h')
            if !isdirectory(l:dir)
                call mkdir(l:dir, 'p')
            endif
        endif
    endfunction
endif

" Spell check
set spellfile="~/.vim/spell/en.utf-8.add"

" ==========
" Shortcuts
" ==========

" quit
map <leader><Esc><Esc> :qa<CR>

" Add insert semi-colon shortcut
inoremap ;; <End>;<Esc>
nnoremap ;; A;<Esc>

" Add insert comma shortcut
inoremap ,, <End>,<Esc>
nnoremap ,, A,<Esc>

" lambda
inoremap ¬ λ

" hide search results with \/
nnoremap <silent> <leader>/ :nohlsearch<CR>

" Map \q to close buffer
nmap <leader><Esc> :lcl<CR>:ccl<CR>
nmap <leader>q :lcl<CR>:BD<CR>
nmap <leader>Q :lcl<CR>:ccl<CR>:bd *<C-a><CR><CR>
nmap <leader>qq :lcl<CR>:bd<CR>

" preferences
map <leader>, :e ~/.vimrc<CR>

" save
map <leader>w :w<CR>
map <leader>W :w<CR>

" replace single quotes in selection
map <leader>" :s/'/"/g<CR>

" sort
map <leader>j :'<,'>sort i<CR>

" =============
" Plugin Config
" =============

" Airline
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_theme = 'solarized'
let g:airline#extensions#ale#enabled = 1

" Ale
let g:ale_fix_on_save = 1

let g:ale_sign_error = '✕'
let g:ale_sign_warning = '!'
let g:ale_lint_delay = 2000

let g:ale_javascript_eslint_use_global = 1

let g:ale_php_phpcs_standard = 'PSR1,PSR2'
let g:ale_php_phpmd_ruleset = 'codesize,design,unusedcode,naming,/Users/mark/.vim/syntastic/sandi-metz.xml'

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'haskell': ['hfmt']
\}

let g:ale_linters = {
\   'javascript': ['eslint', 'flow'],
\   'haskell': ['stack-ghc', 'hlint'],
\   'html': ['tidy'],
\   'md': [],
\}

nnoremap ? :ALEDetail<CR>

" fzf
map <c-p> :Files<CR>
map <c-o> :Buffers<CR>

let g:fzf_layout = { 'down': '7em' }

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Gundo
nnoremap <leader>u :GundoToggle<CR>

" argwrap
nnoremap <silent> <leader>a :ArgWrap<CR>

" Solarized
syntax enable
set term=screen-256color
set background=dark
silent! colorscheme solarized
highlight clear SignColumn
call gitgutter#highlight#define_highlights()
hi clear SpellBad
hi SpellBad cterm=underline ctermfg=5

" NERDtree
map <leader>n :NERDTreeToggle<CR>
map <leader>f :NERDTreeFind<CR>
map <leader>r :vertical res 30<CR>
let g:NERDTreeShowHidden=1
let g:NERDTreeIgnore = [
\    '\.DS_Store[[file]]',
\    'Session.vim[[file]]',
\    'slides.html$[[file]]',
\    'notes.html$[[file]]',
\    'challenges.html$[[file]]',
\   '\.git[[dir]]',
\   'node_modules[[dir]]',
\   'bower_components[[dir]]',
\   'jspm[[dir]]',
\   'output[[dir]]',
\   '\.psci_modules[[dir]]',
\   '_minted-[[dir]]',
\   '\.pulp-cache[[dir]]',
\   '\.stack-work[[dir]]',
\   '\.undodir[[dir]]',
\   'vendor[[dir]]',
\   '^log[[dir]]',
\   '\.zip$[[file]]',
\   '\.gif$[[file]]',
\   '\.jpg$[[file]]',
\   '\.jpeg$[[file]]',
\   '\.png$[[file]]',
\   '\.aux$[[file]]',
\   '\.pyg$[[file]]',
\   '\.log$[[file]]',
\   '\.out$[[file]]',
\   '\.pdf$[[file]]',
\   '\.toc$[[file]]',
\]

" Grepper
map // :Grepper<CR>

" UltiSnips
let g:UltiSnipsSnippetsDir = '~/.vim/snippets'

" goyo
nnoremap <Tab> :Goyo<CR>

" ==============
" Auto Commands
" ==============
augroup vimrc
	" Remove all vimrc autocommands
    autocmd!

    " Non-default file types
    au BufNewFile,BufRead Vagrantfile set filetype=ruby
    au BufNewFile,BufRead Gemfile set filetype=ruby
    au BufNewFile,BufRead Podfile set filetype=ruby
    au BufNewFile,BufRead Berksfile set filetype=ruby
    au BufNewFile,BufRead Cheffile set filetype=ruby
    au BufNewFile,BufRead *.make set filetype=make
    au BufNewFile,BufRead *.yaml set filetype=yml
    au BufNewFile,BufRead *.cabal set filetype=yml
    au BufNewFile,BufRead *.tex set filetype=tex
    au BufNewFile,BufRead .cmt set filetype=conf

    " syntax highlight everything in latex/markdown
    au FileType tex,markdown setlocal synmaxcol=0

    " DelimitMate
    au FileType php let b:delimitMate_matchpairs = '(:),[:],{:}'

    " Spell check
    au FileType markdown,html,txt,tex setlocal spell spelllang=en_gb
    au FileType markdown,html,txt,tex setlocal linebreak
    au FileType tex syntax spell toplevel

    " make non-existent directories
    au BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))

    " Syntax of these languages is fussy over tabs/spaces
    au FileType make setlocal ts=4 sts=4 sw=4 noexpandtab
    au FileType Makefile setlocal ts=4 sts=4 sw=4 noexpandtab
    au FileType yml setlocal ts=2 sts=2 sw=2

    " check for updated file when window changed
    au WinEnter * checktime
augroup END
