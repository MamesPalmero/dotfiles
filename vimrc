call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree',             { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
Plug 'kien/ctrlp.vim'
Plug 'mileszs/ack.vim',                 { 'on': 'Ack' }
Plug 'sjl/gundo.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'ntpeters/vim-better-whitespace'
Plug 'sheerun/vim-polyglot'

call plug#end()



" -----General settings-----

syntax enable                     " Enable syntax highlighting
set encoding=utf-8                " Use an encoding that supports unicode
set number                        " Show line numbers
set ruler                         " Show line and column number
set nowrap                        " Don't wrap lines
set list                          " Show invisible characters
set backspace=indent,eol,start    " Backspace through everything in insert mode
set visualbell                    " Quitar beep de los cojones
set shell=/bin/zsh                " External commands shell
set backupdir^=~/.vim/_backup//   " Backup files
set directory^=~/.vim/_temp//     " Swap files
set background=dark               " Default color maps for dark background
set laststatus=2                  " Always display the status bar

" List chars
set listchars=""                  " Reset the listchars
set listchars=tab:\ \             " A tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.            " Show trailing spaces as dots
set listchars+=extends:>          " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen
set listchars+=precedes:<         " The character to show in the last column when wrap is
                                  " off and the line continues beyond the left of the screen

" Ignore files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem               " Disable output and VCS files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz                           " Disable archive files
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*      " Ignore bundler and sass cache
set wildignore+=*/tmp/librarian/*,*/.vagrant/*,*/.kitchen/*,*/vendor/cookbooks/*  " Ignore librarian-chef, vagrant, test-kitchen and Berkshelf cache
set wildignore+=*/tmp/cache/assets/*/sprockets/*,*/tmp/cache/assets/*/sass/*      " Ignore rails temporary asset caches
set wildignore+=*.swp,*~,._*                                                      " Disable temp and backup files
set wildignore+=*/node_modules/*                                                  " Ignore node modules

" Indentation options
set autoindent                    " New lines inherit the indentation of previous lines
set tabstop=2                     " A tab is two spaces
set shiftwidth=2                  " An autoindent (with <<) is two spaces
set expandtab                     " Use spaces, not tabs

" Search options
set hlsearch                      " Highlight matches
set incsearch                     " Incremental searching
set ignorecase                    " Searches are case insensitive...
set smartcase                     " ... unless they contain at least one capital letter

" Colors viaul mode
hi Visual ctermfg=255 ctermbg=25

" Colors for searched word
hi Search ctermfg=255 ctermbg=40

" Mouse support
set mouse=a                       " Enable the use of the mouse
set ttymouse=xterm2               " Name of the terminal type for which mouse codes are to be recognized



" -----Custom mappings-----

" Leader key
let mapleader = ","

" Reselect visual block after indent/outdent
vmap < <gv
vmap > >gv

" Use jk as <Esc>
imap jk <Esc>

" Use <Tab> as <Esc>
vnoremap <Tab> <Esc>
onoremap <Tab> <Esc>

" Use <C-c> to copy in system's clipboard
vnoremap <C-c> "+y



" -----Custom settings for plugins-----

" Nerdtree
  " Open nerdtree with Ñ
  nmap Ñ :NERDTree <CR>

" Nerdcommenter
  " Comment out the current line or text selected in visual mode with ñ
  map ñ :call NERDComment(0,"toggle") <CR>

" Ack.vim
  " Use Ag with ack.vim
  let g:ackprg = 'ag --vimgrep --smart-case'

  " To search word under cursor
  nmap <Leader>f :Ack <cword><CR>

" Gundo.vim
  nmap <F5> :GundoToggle<CR>
  imap <F5> <ESC>:GundoToggle<CR>

" Vim-multiple-cursors
  " Use <Tab> as <Esc>
  let g:multi_cursor_quit_key='<Tab>'

  " https://github.com/terryma/vim-multiple-cursors#gmulti_cursor_insert_maps-default-
  let g:multi_cursor_insert_maps={'j':1}

" Unimpaired
  " Bubble single lines
  nmap <C-Up> [e
  nmap <C-Down> ]e
  nmap <C-k> [e
  nmap <C-j> ]e

  " Bubble multiple lines
  vmap <C-Up> [egv
  vmap <C-Down> ]egv
  vmap <C-k> [egv
  vmap <C-j> ]egv



" -----References-----
" https://junegunn.kr/2014/07/vim-plugins-and-startup-time/
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/
" https://github.com/carlhuda/janus/blob/f285edf1533eaecf526dabe0962dcd5107319af7/janus/vim/core/before/plugin/
" Script to print colors: https://askubuntu.com/questions/821157/print-a-256-color-test-pattern-in-the-terminal/821163#821163
