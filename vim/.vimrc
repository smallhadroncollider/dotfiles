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
Plugin 'bling/vim-airline' " airline status bar
Plugin 'christoomey/vim-tmux-navigator' " vim/tmux window navigation
Plugin 'editorconfig/editorconfig-vim' " EditorConfig support
Plugin 'FooSoft/vim-argwrap' " wrap/unwrap arguments
Plugin 'jacquesbh/vim-showmarks' " show marks
Plugin 'jaxbot/syntastic-react' 
Plugin 'kien/ctrlp.vim' " CtrlP
Plugin 'mattn/emmet-vim' " emmet - `ctrl-y ,` to activate
Plugin 'Raimondi/delimitMate' " adds matching end brackets
Plugin 'qpkorr/vim-bufkill' " keeps splits when killing buffers
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic' " Syntastic - Linter
Plugin 'sjl/gundo.vim'
Plugin 'skwp/greplace.vim' " search and replace
Plugin 'terryma/vim-multiple-cursors' " multiple cursors
Plugin 'tomtom/tcomment_vim' " smart commenting
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-scripts/AutoComplPop' 
Plugin 'xolox/vim-misc' " required for vim sessions
Plugin 'xolox/vim-session' " vim sessions

" syntax highlighting
Plugin 'keith/swift.vim'
Plugin 'mxw/vim-jsx'
Plugin 'othree/html5.vim' " html5 syntax highlighting
Plugin 'pangloss/vim-javascript' " javascript syntax highlighting
Plugin 'raichoo/purescript-vim' " purescript syntax highlighting
Plugin 'StanAngeloff/php.vim' " Better PHP syntax highlighting
Plugin 'xsbeats/vim-blade'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


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
au WinEnter * checktime " check for updated file when window changed

" Don't redraw while executing macros (good performance config)
set lazyredraw
set updatetime=4000

" Always show current position
set ruler
set cursorline

" Keep cursor more in middle
set scrolloff=15

" sounds off
set noerrorbells
set novisualbell

" Map \q to close buffer
nmap <leader><Esc> :lcl<CR>:ccl<CR>
nmap <leader>q :lcl<CR>:BD<CR>
nmap <leader>Q :NERDTreeClose<CR>:bd *<C-a><CR><CR>
nmap <leader>qq :lcl<CR>:bd<CR>

" preferences
map <leader>, :e ~/.vimrc<CR>

" preferences
map <leader>] :bn<CR>
map <leader>[ :bp<CR>

" save
map <leader>w :w<CR>
map <leader>W :w<CR>

" replace single quotes in selection
map <leader>" :s/'/"/g<CR>

" sort out tabs
map <leader><Tab> :'<,'>ret<CR>

" sort
map <leader>j :'<,'>sort i<CR>

" Highlight search results
set hlsearch
set incsearch
nnoremap <silent> <leader>/ :nohlsearch<CR> " hide search results with \/

" Set utf8 as standard encoding
set encoding=utf8
set fileencoding=utf-8

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

" Add insert semi-colon shortcut
inoremap ;; <End>;<Esc>
nnoremap ;; A;<Esc>

" Add insert comma shortcut
inoremap ,, <End>,<Esc>
nnoremap ,, A,<Esc>

" Add insert tick shortcut
inoremap <leader><space> <End> ✓<Esc>
nnoremap <leader><space> A ✓<Esc>

" backups
set backupdir=~/.vim/tmp
set directory=~/.vim/tmp

" Syntax of these languages is fussy over tabs/spaces
autocmd FileType make setlocal ts=4 sts=4 sw=4 noexpandtab
autocmd FileType yml setlocal ts=2 sts=2 sw=2

" Non-default file types 
autocmd BufNewFile,BufRead Vagrantfile set filetype=ruby
autocmd BufNewFile,BufRead Gemfile set filetype=ruby
autocmd BufNewFile,BufRead Podfile set filetype=ruby
autocmd BufNewFile,BufRead Berksfile set filetype=ruby
autocmd BufNewFile,BufRead Cheffile set filetype=ruby
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

" half window
nnoremap <leader>h :rightb vnew<cr>

" Grep shortcut
map <leader>// :grep
map <leader>s :cw<Esc>

" show marks
autocmd VimEnter * DoShowMarks!

" Spell check
autocmd FileType markdown,html,txt setlocal spell spelllang=en_gb
:hi SpellBad cterm=underline ctermfg=red

" test
map <leader>t :! bin/tests<Esc>


" =============
" Plugin Config
" =============

" Airline
set laststatus=2
let g:airline_powerline_fonts=1
let g:airline_theme="solarized"

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 2
let g:syntastic_aggregate_errors = 1
let g:syntastic_check_on_open = 0
let g:syntastic_scss_scss_lint_args = "-c ~/.scss-lint.yml" " Set scss-lint config file
let g:syntastic_php_phpcs_args = "--standard=PSR1,PSR2"
let g:syntastic_php_phpmd_post_args = "codesize,design,unusedcode,naming,/Users/mark/.vim/syntastic/sandi-metz.xml"
let g:syntastic_error_symbol = "✕"
let g:syntastic_style_error_symbol = "×"
let g:syntastic_warning_symbol = "!!"
let g:syntastic_style_warning_symbol = "!"
let g:syntastic_javascript_checkers = ["eslint"]

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
    let g:ctrlp_user_command = 'ag %s -l --nocolor -U --depth -1 --follow --hidden -g ""'

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
endif

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

" DelimitMate
au FileType php let b:delimitMate_matchpairs = "(:),[:],{:}"

" AutoComplPop
inoremap <expr> <C-j> ((pumvisible())?("\<C-n>"):("\<C-j>"))
inoremap <expr> <C-k> ((pumvisible())?("\<C-p>"):("\<C-k>"))

function! Multiple_cursors_before()
    exe "AcpLock" 
endfunction

function! Multiple_cursors_after()
    exe "AcpUnlock"
endfunction

" greplace
set grepprg=ag
let g:grep_cmd_opts = "--line-numbers --noheading"

" vim sessions
set sessionoptions-=options
let g:session_lock_enabled = 0
let g:session_autoload = "yes"
let g:session_autosave = "yes"
let g:session_autosave_periodic = 1
let g:session_autosave_silent = 1
