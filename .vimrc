" Ensure we're using vim, not vi
set nocompatible

" Enable pathogen
execute pathogen#infect()

" Allow backspacing over anything in insert mode
set backspace=indent,eol,start

" Set backup files
set backup
set backupdir=~/backup/vim
set dir=~/backup/vim

set history=50 " Keep 50 commands in history
set ruler " Show cursor position at all times
set showcmd " Show incomplete commands

" ----- Stuff from "Vim in 11 years" -----
" Fix long line movement
:nmap j gj
:nmap k gk
" Professor VIM says '87% of users prefer jj over esc', jj abrams strongly disagrees
imap jj <Esc>

" sudo save!
cmap w!! %!sudo tee > /dev/null %

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
:set infercase
:set ignorecase
:set smartcase

" Highlight the currently searched term
:set hlsearch
:nmap \q :nohlsearch<CR>

" C-e to open previous buffer
" :nmap <C-e> :e#<CR>

" Switch between buffers
:nmap <C-n> :bnext<CR>
:nmap <C-p> :bprev<CR>


" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif


" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on
  autocmd bufwritepost .vimrc source $MYVIMRC

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
endif " has("autocmd")

" OSX Clipboard
" doesn't work without +X11
" set clipboard=+unnamed

set wildignore=*.o,*~,*.pyc

" Set up colorscheme
set t_Co=256
colorscheme solarized
syntax on

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=r
    set guioptions+=e
    set guitablabel=%M\ %t
    set lines=45
    set columns=85
    set guifont=Monaco:h11
    set background=dark " dark for solarized dark, light for the light one
else
    set background=dark " dark for solarized dark, light for the light one
endif

" turning off physical line wrapping
" set textwidth=0 wrapmargin=0 (old config)
set textwidth=79
set formatoptions=qrn1 "(default was [t]croql, current may need t too)

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

" enable line numbers
set nu

" show tabs etc, \w to toggle.
:set list listchars=tab:>-,trail:~,extends:>,precedes:<
:nmap \w :set list!<CR>

" Spell checking for latex files
au FileType tex set spl=en_gb spell

au BufNewFile,BufRead *.md set filetype=markdown

function! Indent_tabs()
    setl softtabstop=4
    setl shiftwidth=4
    setl tabstop=4
    setl noexpandtab
endfunction

function! Indent_4_spaces()
    setl expandtab
    setl autoindent
    setl shiftwidth=4
    setl tabstop=4
    setl softtabstop=4
endfunction

function! Indent_2_spaces()
    setl expandtab
    setl autoindent
    setl shiftwidth=2
    setl tabstop=2
    setl softtabstop=2
endfunction

set expandtab autoindent shiftwidth=4 tabstop=4 softtabstop=4
au FileType erlang call Indent_tabs()
au FileType go call Indent_tabs()
au FileType haskell call Indent_2_spaces()
au FileType html call Indent_2_spaces()
au FileType javascript call Indent_2_spaces()
au FileType python call Indent_tabs()
au FileType ruby call Indent_2_spaces()

""""""""""""""" PLUGIN STUFF """""""""""""

" switch solarized themes
call togglebg#map("<F4>")

" enable ctrlp.vim
let g:ctrlp_map= '<c-m>'

" start of default statusline
set statusline=%f\ %h%w%m%r\ 

" Syntastic statusline
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" end of default statusline (with ruler)
set statusline+=%=%(%l,%c%V\ %=\ %P%)

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_disabled_filetypes = ['sass']


""""""""""""""" NEOVIM STUFF """""""""""""
if has('nvim')
    tnoremap <C-[> <C-\><C-n>
endif
