-- Line numbers settings
vim.o.number = true
vim.o.relativenumber = true
vim.api.nvim_exec([[
  augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * if &buftype != "terminal" | set relativenumber | endif
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
  augroup end
]], false)

vim.o.signcolumn = 'yes'
vim.api.nvim_exec([[
  autocmd InsertEnter * set guicursor+=a:blinkon1
  autocmd InsertLeave * set guicursor+=a:blinkon0
  autocmd FileType nerdtree set norelativenumber
  autocmd FileType nerdtree set signcolumn=no
]], false)

-- Hide window separator and set line number color
vim.o.showtabline = 2
vim.cmd('hi WinSeparator ctermbg=none ctermfg=0 guifg=NvimDarkGrey3')
vim.cmd('hi LineNR ctermfg=8')
vim.cmd('hi SignColumn ctermfg=7 ctermbg=none')

-- Set up nerdtree to not show line numbers
vim.api.nvim_exec([[
  autocmd BufEnter,FocusGained,InsertLeave * if(exists('t:NERDTreeBufName') && bufname('%') == t:NERDTreeBufName) | set nornu | endif
]], false)
