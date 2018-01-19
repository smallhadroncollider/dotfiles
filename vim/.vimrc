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
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'lvht/tagbar-markdown'
Plug 'majutsushi/tagbar', { 'do': 'brew install ctags-exuberant' }
Plug 'maralla/completor.vim', { 'do': 'make js && rm yarn.lock' }
Plug 'mhinz/vim-grepper', { 'on': 'Grepper' }
Plug 'qpkorr/vim-bufkill' " keeps splits when killing buffers
Plug 'Raimondi/delimitMate' " adds matching end brackets
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'SirVer/ultisnips'
Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }
Plug 'skywind3000/asyncrun.vim'
Plug 'terryma/vim-multiple-cursors' " multiple cursors
Plug 'tomtom/tcomment_vim' " smart commenting
Plug 'tpope/vim-fugitive' " git
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-php/tagbar-phpctags.vim', { 'for': 'php', 'do': 'brew install homebrew/php/phpctags' }
Plug 'w0rp/ale' " linter

" syntax highlighting
Plug 'GutenYe/json5.vim'
Plug 'mxw/vim-jsx'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript' " better javascript
Plug 'PProvost/vim-ps1' " powershell
Plug 'raichoo/purescript-vim'
Plug 'StanAngeloff/php.vim' " better PHP
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

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4

set autoindent "Auto indent
set smartindent "Smart indent

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

" Non-default file types
autocmd BufNewFile,BufRead Vagrantfile set filetype=ruby
autocmd BufNewFile,BufRead Gemfile set filetype=ruby
autocmd BufNewFile,BufRead Podfile set filetype=ruby
autocmd BufNewFile,BufRead Berksfile set filetype=ruby
autocmd BufNewFile,BufRead Cheffile set filetype=ruby
autocmd BufNewFile,BufRead *.make set filetype=make
autocmd BufNewFile,BufRead *.yaml set filetype=yml
autocmd BufNewFile,BufRead *.cabal set filetype=yml

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
:hi SpellBad cterm=underline ctermfg=red

" ==========
" Shortcuts
" ==========

" quit
map <leader><Esc><Esc> :qa<CR>

" show location list
map <leader>! :lopen<CR>

" test
map <leader>t :copen<CR>:AsyncRun! bin/tests<CR>

" Add insert semi-colon shortcut
inoremap ;; <End>;<Esc>
nnoremap ;; A;<Esc>

" tick line
map <leader><Space> A ✓<Esc>

" install plugins
map <leader>,, :PlugInstall<CR>:PlugClean<CR>q

" Add insert comma shortcut
inoremap ,, <End>,<Esc>
nnoremap ,, A,<Esc>

" lambda
inoremap ¬ λ

" copy path
map <leader>= :silent !echo % \| pbcopy<CR>:redraw!<CR>


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

" sort out tabs
map <leader><Tab> :'<,'>ret<CR>

" sort
map <leader>j :'<,'>sort i<CR>

" git

" alt-s
map ß :Gstatus<CR>

" alt-d
map ∂ :Gdiff<CR>

" alt-a
map å :Gwrite<CR>

" alt-m
map µ :Gcommit<CR>

" alt-r
map ® :Gremove<CR>

" alt-/
map ÷ :Gblame<CR>

" alt--
map – :Git reset %<CR>

" alt-x
map ≈ :Gread<CR>

" =============
" Plugin Config
" =============

" Airline
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_theme = 'solarized'
let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])
let g:airline#extensions#ale#enabled = 1

" Ale
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1

let g:ale_sign_error = '✕'
let g:ale_sign_warning = '!'
let g:ale_lint_delay = 500

let g:ale_javascript_eslint_use_global = 1

let g:ale_php_phpcs_standard = 'PSR1,PSR2'
let g:ale_php_phpmd_ruleset = 'codesize,design,unusedcode,naming,/Users/mark/.vim/syntastic/sandi-metz.xml'

let g:ale_fixers = ['remove_trailing_lines', 'trim_whitespace']

let g:ale_linters = {
\   'javascript': ['eslint', 'flow'],
\   'haskell': ['stack-ghc-mod', 'hdevtools', 'hlint', 'stack-build', 'stack-ghc'],
\   'html': ['tidy'],
\}

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
\   'build[[dir]]',
\   'node_modules[[dir]]',
\   'bower_components[[dir]]',
\   'jspm[[dir]]',
\   'output[[dir]]',
\   '\.psci_modules[[dir]]',
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
\]

" Grepper
map // :Grepper<CR>

" UltiSnips
let g:UltiSnipsSnippetsDir = '~/.vim/snippets'

" Completor
let g:completor_css_omni_trigger = '([\w-]+|@[\w-]*|[\w-]+:\s*[\w-]*)$'
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

" tagbar
nmap tt :TagbarToggle<CR>
let g:tagbar_left = 0
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1
let g:tagbar_autoshowtag = 1
let g:tagbar_sort = 0
let g:tagbar_width = 30

let g:tagbar_type_haskell = {
    \ 'ctagsbin'  : 'hasktags',
    \ 'ctagsargs' : '-x -c -o-',
    \ 'kinds'     : [
        \  'm:modules:0:1',
        \  'd:data: 0:1',
        \  'd_gadt: data gadt:0:1',
        \  't:type names:0:1',
        \  'nt:new types:0:1',
        \  'c:classes:0:1',
        \  'cons:constructors:1:1',
        \  'c_gadt:constructor gadt:1:1',
        \  'c_a:constructor accessors:1:1',
        \  'ft:function types:1:1',
        \  'fi:function implementations:0:1',
        \  'o:others:0:1'
    \ ],
    \ 'sro'        : '.',
    \ 'kind2scope' : {
        \ 'm' : 'module',
        \ 'c' : 'class',
        \ 'd' : 'data',
        \ 't' : 'type'
    \ },
    \ 'scope2kind' : {
        \ 'module' : 'm',
        \ 'class'  : 'c',
        \ 'data'   : 'd',
        \ 'type'   : 't'
    \ }
\ }

" ==============
" Auto Commands
" ==============
augroup vimrc
	" Remove all vimrc autocommands
    autocmd!

    " DelimitMate
    au FileType php let b:delimitMate_matchpairs = '(:),[:],{:}'

    " Spell check
    autocmd FileType markdown,html,txt,tex setlocal spell spelllang=en_gb
    autocmd FileType markdown,html,txt,tex setlocal linebreak
    autocmd FileType tex syntax spell toplevel
    autocmd FileType tex syntax sync fromstart 

    " make non-existent directories
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))

    " Syntax of these languages is fussy over tabs/spaces
    autocmd FileType make setlocal ts=4 sts=4 sw=4 noexpandtab
    autocmd FileType yml setlocal ts=2 sts=2 sw=2

    " check for updated file when window changed
    au WinEnter * checktime
augroup END
