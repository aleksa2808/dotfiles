"------------------------------------------------------------
" Features {{{1

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Better terminal window title
set title

" Let airline take care of mode indicators
set noshowmode

" Highlight searches while typing
set incsearch

" Faster response times
" default 4000
set updatetime=300

" Make splits more like i3
set splitbelow

" Set cursor scrolling offset
set scrolloff=3

" Create .swp files in a central directory
" (can cause problems if enabled on a multi-user machine)
set directory^=$HOME/.vim/swap//

" Easier relative movement
set relativenumber

" Plugins
call plug#begin('~/.vim/plugged')

" ide-like visual/navigational features
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'kien/ctrlp.vim'

" color themes
Plug 'joshdick/onedark.vim'
" Plug 'vim-airline/vim-airline-themes'

" tpope the man the myth the legend
" git wrapper
Plug 'tpope/vim-fugitive'
" easy code commenting
Plug 'tpope/vim-commentary'
" auto identify indent settings
Plug 'tpope/vim-sleuth'
" easy bracketting
Plug 'tpope/vim-surround'
" . functionality for non-native commands
Plug 'tpope/vim-repeat'

" code completion
" needs additional install flags depending on the needed language
" eg. './install --clang-completer' for C/C++
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py' }
" program tag explorer
Plug 'majutsushi/tagbar'
" git diff sidebar indicators
Plug 'airblade/vim-gitgutter'
" better syntax highlighting
Plug 'sheerun/vim-polyglot'
" code syntax linting
" Plug 'w0rp/ale'
" easy code formatting
Plug 'Chiel92/vim-autoformat'
" .h <> .cpp file switching
Plug 'vim-scripts/a.vim'

" i3wm config syntax highlighting!
Plug 'PotatoesMaster/i3-vim-syntax'

call plug#end()

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Enable syntax highlighting
syntax on
colorscheme onedark

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

let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
" let g:airline_theme='onedark'

" show hidden files and folders by default
let g:ctrlp_show_hidden=1
let g:NERDTreeShowHidden=1

" open files/folders with a single click
let g:NERDTreeMouseMode = 3

let g:ycm_autoclose_preview_window_after_completion = 1

" open nerdtree at startup if no specific file was given
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" close vim if only nerdtree remains
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

noremap <F3> :Autoformat<CR>
nnoremap <F4> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>

"------------------------------------------------------------
" Must have options {{{1

" Vim with default settings does not allow easy switching between multiple files
" in the same editor window. Users can use multiple split windows or multiple
" tab pages to edit multiple files, but it is still best to enable an option to
" allow easier switching between files.
"
" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden

" Note that not everyone likes working this way (with the hidden option).
" Alternatives include using tabs or split windows instead of re-using the same
" window as mentioned above, and/or either of the following options:
" set confirm
" set autowriteall

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch

" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline


"------------------------------------------------------------
" Usability options {{{1

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=

" Enable use of the mouse for all modes
set mouse=a

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

" Display line numbers on the left
set number

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=10

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>


"------------------------------------------------------------
" Indentation options {{{1

" Indentation settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=4
set softtabstop=4
set expandtab

" Indentation settings for using hard tabs for indent. Display tabs as
" four characters wide.
"set shiftwidth=4
"set tabstop=4


"------------------------------------------------------------
" Mappings {{{1

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

"------------------------------------------------------------
