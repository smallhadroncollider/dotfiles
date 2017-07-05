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
Plug 'maralla/completor.vim', { 'do': 'make js && rm yarn.lock' }
Plug 'mhinz/vim-grepper', { 'on': 'Grepper' }
Plug 'qpkorr/vim-bufkill' " keeps splits when killing buffers
Plug 'Raimondi/delimitMate' " adds matching end brackets
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'sdeleon28/vim-todo', { 'for': 'todo' } " todo files
Plug 'SirVer/ultisnips'
Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }
Plug 'skywind3000/asyncrun.vim'
Plug 'terryma/vim-multiple-cursors' " multiple cursors
Plug 'thaerkh/vim-workspace'
Plug 'tomtom/tcomment_vim' " smart commenting
Plug 'tpope/vim-fugitive' " git
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale' " linter

" syntax highlighting
Plug 'GutenYe/json5.vim'
Plug 'mxw/vim-jsx'
Plug 'othree/html5.vim' " html5 syntax highlighting
Plug 'pangloss/vim-javascript' " javascript syntax highlighting
Plug 'raichoo/purescript-vim' " purescript syntax highlighting
Plug 'StanAngeloff/php.vim' " Better PHP syntax highlighting
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

" Keep cursor more in middle
set scrolloff=15

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

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4

set autoindent "Auto indent
set smartindent "Smart indent
set number " line numbers

" Backspace navigation
set backspace=indent,eol,start

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

" test
map <leader>t :copen<CR>:AsyncRun! bin/tests<CR>

" Add insert semi-colon shortcut
inoremap ;; <End>;<Esc>
nnoremap ;; A;<Esc>

" install plugins
map <leader>,, :PlugInstall<CR>:PlugClean<CR>q

" Add insert comma shortcut
inoremap ,, <End>,<Esc>
nnoremap ,, A,<Esc>

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

" Ale
let g:ale_sign_error = '✕'
let g:ale_sign_warning = '!'

let g:ale_php_phpcs_standard = 'PSR1,PSR2'
let g:ale_php_phpmd_ruleset = 'codesize,design,unusedcode,naming,/Users/mark/.vim/syntastic/sandi-metz.xml'

let g:ale_linters = {
\   'javascript': ['eslint', 'flow'],
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
colorscheme solarized
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
\   '\.git[[dir]]',
\   'build[[dir]]',
\   'node_modules[[dir]]',
\   '\.undodir[[dir]]',
\   'vendor[[dir]]',
\   'log[[dir]]'
\]

" Grepper
map // :Grepper<CR>

" UltiSnips
let g:UltiSnipsSnippetsDir = '~/.vim/snippets'

" Completor
let g:completor_php_omni_trigger = '([$\w]+|->[$\w]*|::[$\w]*|implements\s*|extends\s*|class\s+[$\w]+|new\s*)$'
let g:completor_css_omni_trigger = '([\w-]+|@[\w-]*|[\w-]+:\s*[\w-]*)$'
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

" vim-workspace
nnoremap <leader>s :ToggleWorkspace<CR>

" ==============
" Auto Commands
" ==============
augroup vimrc
	" Remove all vimrc autocommands
    autocmd!

    " DelimitMate
    au FileType php let b:delimitMate_matchpairs = '(:),[:],{:}'

    " Spell check
    autocmd FileType markdown,html,txt setlocal spell spelllang=en_gb

    " make non-existent directories
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))

    " Syntax of these languages is fussy over tabs/spaces
    autocmd FileType make setlocal ts=4 sts=4 sw=4 noexpandtab
    autocmd FileType yml setlocal ts=2 sts=2 sw=2

    " check for updated file when window changed
    au WinEnter * checktime
augroup END
