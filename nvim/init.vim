call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdtree',                           { 'on': 'NERDTreeToggle' }
Plug 'junegunn/fzf',                                  { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'terryma/vim-multiple-cursors'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'ntpeters/vim-better-whitespace'
Plug 'nvim-treesitter/nvim-treesitter',               {'do': ':TSUpdate'}
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'Shatur/neovim-ayu'
Plug 'neoclide/coc.nvim',                             {'branch': 'release'}
call plug#end()



" -----General settings-----

syntax enable                              " Enable syntax highlighting
set encoding=utf-8                         " Use an encoding that supports unicode
set number                                 " Show line numbers
set ruler                                  " Show line and column number
set nowrap                                 " Don't wrap lines
set list                                   " Show invisible characters
set backspace=indent,eol,start             " Backspace through everything in insert mode
set visualbell                             " Quitar beep de los cojones
set shell=/bin/zsh                         " External commands shell
set backupdir^=~/.config/nvim/_backup//    " Backup files
set directory^=~/.config/nvim/_temp//      " Swap files
set background=dark                        " Default color maps for dark background
set laststatus=2                           " Always display the status bar

" Indentation options
set autoindent                             " New lines inherit the indentation of previous lines
set tabstop=2                              " A tab is two spaces
set shiftwidth=2                           " An autoindent (with <<) is two spaces
set expandtab                              " Use spaces, not tabs

" Search options
set hlsearch                               " Highlight matches
set incsearch                              " Incremental searching
set ignorecase                             " Searches are case insensitive...
set smartcase                              " ... unless they contain at least one capital letter

" Mouse support
set mouse=a                                " Enable the use of the mouse

" List chars
set listchars=""                           " Reset the listchars
set listchars=tab:\ \                      " A tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.                     " Show trailing spaces as dots
set listchars+=extends:>                   " The character to show in the last column when wrap is
                                           " off and the line continues beyond the right of the screen
set listchars+=precedes:<                  " The character to show in the last column when wrap is
                                           " off and the line continues beyond the left of the screen



" -----General custom mappings-----

" Leader key
let mapleader = ","

" Reselect visual block after indent/outdent
vmap < <gv
vmap > >gv

" Use jk as <Esc>
imap jk <Esc>

" Use <C-c> to copy in system's clipboard
vnoremap <C-c> "+y



" -----Autocommands-----

" Ensure that nopaste is always set
au InsertLeave * set nopaste



" -----Custom settings for plugins-----

" Nerdtree
  " Open nerdtree with Ñ
  nmap Ñ :NERDTree <CR>

" Commentary
  " Comment or uncomment [count] lines with ñ
  nmap ñ gcc
  " Comment or uncomment the highlighted lines with ñ
  vmap ñ gc

" Fzf
  " Open file finder
  nmap <Leader>p :Files<CR>
  " https://github.com/junegunn/fzf#respecting-gitignore
  let $FZF_DEFAULT_COMMAND = 'ag -g ""'

  " Open file history
  nmap <Leader>h :History<CR>

" Undotree
  " Open undo tree
  nnoremap <F5> :UndotreeToggle<CR>

" Vim-multiple-cursors
  " https://github.com/terryma/vim-multiple-cursors#gmulti_cursor_insert_maps-default-
  let g:multi_cursor_insert_maps={'j':1}

" Rooter
  " The project root is identified by
  let g:rooter_patterns = ['.git']

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

" Treesitter
  " Enable treesitter
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"elixir", "heex", "javascript"},
  sync_install = false,
  auto_install = true,
  highlight = { enable = true },
  indent = {
    enable = true,
    disable = { "heex" },
  },
  context_commentstring = { enable = true },
}
EOF
  " Treesitter based folding
  set foldmethod=expr
  set foldexpr=nvim_treesitter#foldexpr()
  set foldlevel=99
  " Colorschema with treesitter support
  colorscheme ayu


" Coc.nvim
  " Install elixirLS for coc-elixir manually from https://github.com/elixir-lsp/elixir-ls/releases/
  " unzip elixir-ls-'version'.zip -d ~/.local/share/nvim/release/
  let g:coc_global_extensions = ['coc-json', 'coc-tsserver', 'coc-prettier', 'coc-eslint', 'coc-svelte', 'coc-css', 'coc-elixir']

  " Use tab for trigger completion with characters ahead and navigate.
  inoremap <silent><expr> <TAB>
        \ coc#pum#visible() ? coc#pum#next(1) :
        \ CheckBackspace() ? "\<Tab>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

  function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Remap keys for gotos
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use K to show documentation in preview window.
  nnoremap <silent> K :call ShowDocumentation()<CR>

  function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
      call CocActionAsync('doHover')
    else
      call feedkeys('K', 'in')
    endif
  endfunction

  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Call the 'format' action manually
  nmap <Leader>f :call CocAction('format')<CR>


" -----References-----
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/
" https://github.com/carlhuda/janus/blob/f285edf1533eaecf526dabe0962dcd5107319af7/janus/vim/core/before/plugin/
" Script to print colors: https://askubuntu.com/questions/821157/print-a-256-color-test-pattern-in-the-terminal/821163#821163
