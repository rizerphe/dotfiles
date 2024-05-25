let g:coc_disable_startup_warning = 1

call plug#begin('~/.config/nvim/plug')
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'preservim/nerdtree'
"  Plug 'sheerun/vim-polyglot'
  Plug 'mbbill/undotree'
  Plug 'ryanoasis/vim-devicons'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'itchyny/lightline.vim'
  Plug 'mengelbrecht/lightline-bufferline'
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  Plug 'mlaursen/vim-react-snippets'
"  Plug 'jiangmiao/auto-pairs'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/nvim-treesitter-context'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
"  Plug 'arcticicestudio/nord-vim'
  Plug 'chrisbra/Colorizer'
  Plug 'github/copilot.vim'
  Plug 'junegunn/rainbow_parentheses.vim'
  Plug 'yaegassy/coc-ruff', {'do': 'yarn install --frozen-lockfile'}
"   Plug 'wellle/context.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'mfussenegger/nvim-dap'
  Plug 'rcarriga/nvim-dap-ui'
  Plug 'tikhomirov/vim-glsl'
call plug#end()

lua << EOF

local dap = require('dap')
dap.adapters.lldb = {
  type = 'executable',
  command = '/bin/lldb-vscode', -- adjust as needed, must be absolute path
  name = 'lldb'
}

local dap = require('dap')
dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

local dapui = require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
require("dapui").setup()

get_options = function(desc)
    local options = { noremap = true, silent = true }
    if desc then
        options.desc = desc
    end
    return options
end

keymap = vim.api.nvim_set_keymap
keymap(
    "n",
    "zp",
    ":lua require'dap'.toggle_breakpoint()<CR>",
    get_options("Debugger: Toggle break[p]oint")
)
keymap(
    "n",
    "ze",
    ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '), nil, vim.fn.input('Log point message: '))<CR>",
    get_options("Debugger: Set breakpoint with [e]verything: condition and log")
)
keymap(
    "n",
    "zc",
    ":lua require'dap'.set_breakpoint(vim.fn.input('Condition: '))<CR>",
    get_options("Debugger: Set [c]onditional breakpoint")
)
keymap(
    "n",
    "zl",
    ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log: '))<CR>",
    get_options("Debugger: Set [l]og point")
)
keymap(
    "n",
    "zs",
    ":lua require'dap'.continue()<CR>",
    get_options("Debugger: [s]tart")
)
keymap(
    "n",
    "zi",
    ":lua require'dap'.step_into()<CR>",
    get_options("Debugger: step [i]nto")
)
keymap(
    "n",
    "zo",
    ":lua require'dap'.step_out()<CR>",
    get_options("Debugger: step [o]ut")
)
keymap(
    "n",
    "zn",
    ":lua require'dap'.step_over()<CR>",
    get_options("Debugger: step [n]ext")
)
keymap(
    "n",
    "zb",
    ":lua require'dap'.step_back()<CR>",
    get_options("Debugger: step [b]ack")
)
keymap(
    "n",
    "zt",
    ":lua require'dap'.terminate()<CR>",
    get_options("Debugger: [t]erminate")
)
keymap(
    "n",
    "zm",
    ":lua require('dap-python').test_method()<CR>",
    get_options("Debugger: test [m]ethod")
)
keymap(
    "n",
    "zr",
    ":lua require('dap-python').test_class()<CR>",
    get_options("Debugger: test [r]un whole class")
)

EOF

let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'
imap <C-j> <Plug>(coc-snippets-expand-jump)
xmap <leader>x  <Plug>(coc-convert-snippet)
nmap <C-x> <Plug>(coc-codeaction)
xmap <C-c> <Plug>(coc-codeaction-selected)
nmap <C-c> <Plug>(coc-codeaction-selected)
nmap gd <Plug>(coc-definition)
nmap <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

function! OpenTerminal(...)
    if a:0
        terminal a:1
    else
        terminal
    endif
    setlocal nonumber norelativenumber
    set winfixheight
endfunction

autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python' shellescape(@%, 1)<CR>

autocmd VimEnter * silent! NERDTree | wincmd p
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = ['^node_modules$']

" Enter terminal mode on mouse click
autocmd TermOpen * nnoremap <buffer><LeftRelease> <LeftRelease>i

augroup nerdtreehidecwd
    autocmd!
    autocmd FileType nerdtree syntax match NERDTreeHideCWD #^[</].*$# conceal
augroup end

nnoremap <F5> :UndotreeToggle<CR>

function! ClangFormat(line1, line2)
    let l:lines = getline(a:line1, a:line2)
    let l:formatted = split(system('clang-format', l:lines), '\n')
    call setline(a:line1, l:formatted)
endfunction

" nnoremap <F2> :call CocAction("format")<CR>:call CocAction('organizeImport')<CR>
nnoremap <F2> :call CocAction("format")<CR>
autocmd FileType python nnoremap <F2> :call CocAction("format")<CR>:CocCommand pyright.organizeimports<CR>
autocmd FileType glsl nnoremap <F2> :call ClangFormat(1, line('$'))<CR>
nnoremap <F4> :silent! NERDTreeToggle<CR>
nnoremap <F8> :RainbowParentheses!!<CR>:ColorToggle<CR>
nnoremap <C-p> :GFiles<CR>
nnoremap <F6> :belowright 10split<CR>:call OpenTerminal()<CR>A
nnoremap <leader>c :Copilot disable<CR>
nnoremap <leader>e :Copilot enable<CR>
nmap <C-Tab> :bnext<CR>
nmap <C-S-Tab> :bprevious<CR>

" Transparent background
hi Normal ctermbg=none guibg=none
hi Directory ctermbg=none guibg=none

" COC suggestion box colors
hi Pmenu ctermbg=8 ctermfg=7
hi CocMenuSel ctermbg=0 ctermfg=7
hi PmenuSbar ctermbg=0 ctermfg=7
hi PmenuThumb ctermbg=7 ctermfg=8

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

let g:lightline = {
    \ 'colorscheme': 'nord_transparent',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ], [ 'gitbranch', 'filename', 'modified' ] ],
    \ },
    \ 'tabline': {
    \   'left': [['buffers']],
    \   'right': []
    \ },
    \ 'tab': {
    \   'active': ['filename', 'modified'],
    \   'inactive': ['filename', 'modified']
    \ },
    \ 'component_expand': {
    \   'buffers': 'lightline#bufferline#buffers'
    \ },
    \ 'component_type': {
    \   'buffers': 'tabsel',
    \ },
    \ 'component_function': {
    \   'gitbranch': 'FugitiveHead'
    \ },
    \ 'separator': { 'left': "\ue0b8", 'right': "\ue0be" },
    \ 'subseparator': { 'left': "\ue0bf", 'right': "\ue0bf" }
\ }

let g:lightline#bufferline#clickable = 1
autocmd BufWritePost,TextChanged,TextChangedI * call lightline#update()
let g:lightline.component_raw = {'buffers': 1}

set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * if &buftype != "terminal" | set relativenumber | endif
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
  " autocmd TermClose * execute 'bdelete! ' . expand('<abuf>')
augroup end
set fillchars+=vert:\ 

set signcolumn=yes
autocmd InsertEnter * set guicursor+=a:blinkon1
autocmd InsertLeave * set guicursor+=a:blinkon0
autocmd FileType nerdtree set norelativenumber
autocmd FileType nerdtree set signcolumn=no

set showtabline=2
hi VertSplit ctermfg=8
hi LineNR ctermfg=8
hi SignColumn ctermfg=7 ctermbg=none

autocmd BufEnter * if(exists('t:NERDTreeBufName') && bufname('%') == t:NERDTreeBufName) | set nornu | endif

" COC
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

set whichwrap+=<,>,[,]
hi MatchParen ctermbg=none ctermfg=green

hi TreesitterContext ctermbg=none ctermfg=7
hi TreesitterContextBottom cterm=underline ctermfg=7
hi CocInlayHint ctermbg=none ctermfg=8

set tabstop=4 shiftwidth=4 expandtab
let g:ultisnips_python_style = "google"

set clipboard=unnamedplus
set mouse=a
" source ~/.config/nvim/cocrc.vim
source ~/.nvimrc
