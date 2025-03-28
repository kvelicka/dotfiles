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

cmap Wq wq

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

" Disable annoying shortcuts
inoremap <S-Up> <Nop>
inoremap <S-Down> <Nop>

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
":nmap <C-n> :bnext<CR>
":nmap <C-p> :bprev<CR>


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

set wildignore=*.o,*~,*.pyc,*.beam,*.hi,*.dyn_hi,*.dyn_o,*.cache,*.p_hi,*.p_o,*.a,.mypy_cache

" Set up colorscheme
" set t_Co=256

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

let g:gruvbox_contrast_dark = 'medium'
set background=dark
colorscheme gruvbox
syntax on


" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=r
    set guioptions+=e
    set guitablabel=%M\ %t
    set lines=45
    set columns=85
    set guifont="Input Mono:h11"
endif

if has("unix")
    let s:uname = system("uname -s")
    if s:uname == "Darwin\n"
        if has("gui_vimr")
            colorscheme dracula
        endif
    endif
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
set nohidden

" enable line numbers
set nu
"set relativenumber

" always keep at least 10 lines visible
set scrolloff=5

" show tabs etc, \w to toggle.
set list listchars=tab:»\ ,trail:~,extends:>,precedes:< 
nmap \w :set list!<CR>

" Spell checking for latex files
au FileType tex set spl=en_gb spell

" Set syntax highlighting for new file types
au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.do set filetype=sh
au BufNewFile,BufRead *.config set filetype=erlang
au BufNewFile,BufRead *.escript set filetype=erlang
au BufNewFile,BufRead *.app set filetype=erlang
au BufNewFile,BufRead *.app.src set filetype=erlang

function! Indent_tabs_4s()
    setl softtabstop=4
    setl shiftwidth=4
    setl tabstop=4
    setl noexpandtab
endfunction

function! Indent_tabs_8s()
    setl softtabstop=8
    setl shiftwidth=8
    setl tabstop=8
    setl noexpandtab
endfunction

function! Indent_tabs_2s()
    setl softtabstop=2
    setl shiftwidth=2
    setl tabstop=2
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

" Overtaken by vim-sleuth?
" set expandtab autoindent shiftwidth=2 tabstop=2 softtabstop=2
" au FileType c call Indent_tabs_4s()
" au FileType cpp call Indent_tabs_4s()
" au FileType hpp call Indent_tabs_4s()
" au FileType erlang call Indent_4_spaces()
" au FileType go call Indent_tabs_4s()
" au FileType haskell call Indent_2_spaces()
" au FileType html call Indent_2_spaces()
" au FileType javascript call Indent_2_spaces()
" au FileType python call Indent_tabs_2s()
" au FileType ruby call Indent_2_spaces()
" au FileType sh call Indent_tabs_4s()

autocmd FileType zig setlocal commentstring=//\ %s
autocmd FileType cpp setlocal commentstring=//\ %s

""""""""""""""" PLUGIN STUFF """""""""""""

" might be needed to make erlang tag jumping work properly
"autocmd FileType erlang setlocal iskeyword+=:


" start of default statusline
set statusline=%f\ %h%w%m%r\ 
set cursorline

" Syntastic statusline
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
" end of default statusline (with ruler)
"set statusline+=%{tagbar#currenttag('%s','', 'f', 'scoped-stl')}
set statusline+=%=%{tagbar#currenttag('%s\ ','','f')}
set statusline+=%(%l,%c%V\ %=\ %P%)

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_disabled_filetypes = ['sass']
let g:syntastic_mode_map = { 'passive_filetypes': ['python'] }


""""""""""""""" NEOVIM STUFF """""""""""""
" make esc work for terminal
if has('nvim')
    tnoremap <C-[> <C-\><C-n>
endif

" https://github.com/numirias/security/blob/master/doc/2019-06-04_ace-vim-neovim.md
set nomodeline

" for LanguageClient-neovim setup
"set runtimepath+=~/.vim-plugins/LanguageClient-neovim

" LanguageClient-neovim
"nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
"nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>

"let g:LanguageClient_serverCommands = {
      "\ 'c': ['/home/user/code/ccls/Release/ccls'],
      "\ 'cpp': ['/home/user/code/ccls/Release/ccls']
      "\ }
      "\ 'erlang': ['/home/user/code/sourcer/_build/default/bin/erlang_ls'],

nmap <F8> :TagbarToggle<CR>

" enable ctrlp.vim
let g:ctrlp_map= '<c-p>'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_custom_ignore = {
  \ 'dir':  'ext/',
  \ }
"  \ 'file': '\v\.(exe|so|dll)$',
"  \ 'link': 'some_bad_symbolic_links',
"  \ }


if has('nvim')
    lua require('lua_init')
endif
