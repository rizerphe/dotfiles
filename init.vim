set nocompatible

let g:coc_disable_startup_warning = 1

call plug#begin('~/.config/nvim/plug')
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'preservim/nerdtree'
"  Plug 'sheerun/vim-polyglot'
  Plug 'mbbill/undotree'
  Plug 'ambv/black'
  Plug 'ryanoasis/vim-devicons'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'nvie/vim-flake8'
  Plug 'itchyny/lightline.vim'
  Plug 'mengelbrecht/lightline-bufferline'
  Plug 'severin-lemaignan/vim-minimap'
"  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  Plug 'jiangmiao/auto-pairs'
  Plug 'mlaursen/vim-react-snippets'
"  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

autocmd VimEnter * NERDTree | wincmd p
autocmd BufWinEnter * NERDTreeMirror
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = ['^node_modules$']

nnoremap <F5> :UndotreeToggle<CR>
nnoremap <F2> :Black<CR>
nnoremap <F3> :MinimapToggle<CR>
nnoremap <F4> :NERDTreeToggle<CR>
nnoremap <C-p> :GFiles<CR>

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'tabline': {
      \   'left': [ ['buffers'] ],
      \   'right': [ ['close'] ]
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ }
      \ }
autocmd BufWritePost,TextChanged,TextChangedI * call lightline#update()

:set number relativenumber

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

set guicursor=i:ver1
autocmd InsertEnter * set guicursor=a:blinkon1
autocmd InsertLeave * set guicursor=a:blinkon0
:autocmd FileType nerdtree set norelativenumber
:autocmd FileType taglist set norelativenumber

autocmd BufEnter * if(exists('t:NERDTreeBufName') && bufname('%') == t:NERDTreeBufName) | set nornu | endif

set whichwrap+=<,>,[,]

hi MatchParen ctermbg=none ctermfg=green

set mouse=a
" source ~/.config/nvim/cocrc.vim
source ~/.nvimrc
