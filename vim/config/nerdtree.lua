-- NERDTree autocommands
vim.api.nvim_exec([[
  autocmd VimEnter * silent! NERDTree | wincmd p
  autocmd bufenter * if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif
]], false)
vim.g.NERDTreeMinimalUI = 1
vim.g.NERDTreeIgnore = {'^node_modules$'}

-- Hide NERDTree cwd
vim.api.nvim_exec([[
  augroup nerdtreehidecwd
    autocmd!
    autocmd FileType nerdtree syntax match NERDTreeHideCWD #^[</].*$# conceal
  augroup end
]], false)

-- Key mappings for NERDTree
vim.api.nvim_set_keymap('n', '<F4>', ':silent! NERDTreeToggle<CR>', {})
