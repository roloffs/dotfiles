set number " activates line numbers
"set relativenumber " activates relative line numbers
set ruler " shows current row and column in status line
set showcmd " shows information about executed command in status line
set wildmenu " shows list of matching candidates at command-line completion
set showtabline=2 " always shows tab line
set laststatus=2 " always displays an extra line above status line
"set noshowmode " disables showing the current mode in status line
"set colorcolumn=80 " displays a line at the specified column
"set cursorline " highlights current line (makes cursor movement very laggy)

set background=dark " adapts color scheme for dark background
set showmatch " shows matching brackets
set list " enables displaying non-printable characters
set listchars=tab:»\ ,trail:-,nbsp:+,extends:›,precedes:‹
"set listchars=tab:▸\ ,trail:·,nbsp:·,extends:→,precedes:←
"set listchars=tab:>\ ,trail:-,nbsp:+,extends:>,precedes:<

set hlsearch " highlights search results (:noh unhighlights search results)
set incsearch " jumps to search results already during writing (enclose search term into \< and \> for whole word search)
"set ignorecase " ignore case type for searching (append \C to the search pattern to enforce case sensitive search, \c for case insensitive search)
set smartcase " be case sensitive if word contains an upper case letter

set expandtab " when <tab> key is hit, spaces are inserted instead of <tab> symbols (:retab replaces existing <tab> symbols with spaces, ctrl+v <tab> interts a <tab> symbol in insert mode)
set softtabstop=4 " number of columns, hitting the <tab> key counts for (independent of spaces or <tab> symbols)
set tabstop=4 " number of columns, a <tab> symbol counts for
set smartindent " same indentation like line before + considers curly brackets level (makes autoindent and cindent obsolete)
set shiftwidth=4 " number of columns, indentation counts for (>>, <<)
"set smarttab " ??

set nofoldenable " disables text folding
set clipboard=exclude:.* " disables trying to connect to an X server to enable using the clipboard
set noswapfile
set nobackup
set nowritebackup

set backspace=2 " allows backspace to delete over line ends
"set whichwrap+=<,>,h,l,[,] " allows cursor to move over line ends
"set paste " do not format incoming text (resets a lot of other options)

" enables syntax highlighting
if has("syntax")
    syntax on
endif

" jumps to the last position when reopening a file
"   g'\""   cursor at the bottom of the screen
"   g'\"zz" cursor in the middle of the screen
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"zz" | endif
endif

" after this amount of characters a line break is inserted (only for text files)
"if has("autocmd")
"    autocmd FileType text setlocal textwidth=80
"endif

" loads indentation rules and plugins according to the detected filetype
"if has("autocmd")
"    filetype plugin indent on
"endif

" enable cursor placement by mouse (is required, e.g., not to scroll in tiling window managers, hold shift key to activate normal mouse behavior)
"if has('mouse')
"    set mouse=a
"endif

" tmux (tmux sets the TERM environment variable to 'screen' instead of 'xterm')
if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif
