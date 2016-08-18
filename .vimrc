" Ensure we're using vim, not vi
set nocompatible

" Allow backspacing over anything in insert mode
set backspace=indent,eol,start

" Set backup files
set backup
set backupdir=~/backup/vim

set history=50 " Keep 50 commands in history
set ruler " Show cursor position at all times
set showcmd " Show incomplete commands

" ----- Stuff from "Vim in 11 years" -----
" Fix long line movement
:nmap j gj
:nmap k gk

" Add emacs-like bindings for the command line
:cnoremap <C-a> <Home>
:cnoremap <C-b> <Left>
:cnoremap <C-f> <Right>
:cnoremap <C-d> <Delete>
:cnoremap <M-b> <S-Left>
:cnoremap <M-f> <S-Right>
:cnoremap <M-d> <S-Right><Delete>
:cnoremap <Esc>b <S-Left>
:cnoremap <Esc>f <S-Right>
:cnoremap <Esc>d <S-Right><Delete>
:cnoremap <C-g> <C-c>

" Emacs style highlight-as-you-type search
:set incsearch
" Only match case when capital letters are used
:set ignorecase
:set smartcase

" Highlight the currently searched term
:set hlsearch
:nmap \q :nohlsearch<CR>

" C-e to open previous buffer
:nmap <C-e> :e#<CR>

" Switch between buffers
:nmap <C-n> :bnext<CR>
:nmap <C-p> :bprev<CR>

" Ensure 256 colour term support is enabled 
if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
  set t_Co=256
endif

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Custom settings by kvelicka
set nu " enable line numbers
set noexpandtab " spaces instead of tabs
set tabstop=4
set shiftwidth=4

" OSX Clipboard
set clipboard=unnamed

" Enable highlighting etc
filetype plugin on
filetype indent on
filetype plugin indent on
syntax enable

set wildignore=*.o,*~,*.pyc

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=r
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
    set lines=45
    set columns=85
    set guifont=Monaco:h12
endif

" 0 goes to the first character, not character #0
" map 0 ^ 

" Set up colorscheme
set background=dark " dark for solarized dark, light for the light one
colorscheme solarized

" turning off physical line wrapping
set textwidth=0 wrapmargin=0
" set autoindent for simple indentation
set autoindent

" Set a title to filename
set title

" show filename in the title/header (I think?)
set t_ts=]1;
set t_fs=

" better tab completion
set wildmode=longest,list,full
set wildmenu

" non-saved tabs can be hidden (i.e. non-visible)
set hidden

" switch solarized themes
call togglebg#map("<F5>")

