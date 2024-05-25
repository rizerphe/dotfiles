-- Add the ~/.config/nvim directory to the Lua search path
local config_dir = vim.fn.expand('~/.config/nvim')
package.path = package.path .. ';' .. config_dir .. '/?.lua'

require('config.plugins')
require('config.terminal')
require('config.decorations')

-- Python autocommands
vim.api.nvim_exec([[
  autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python' shellescape(@%, 1)<CR>
]], false)

-- General key mappings
vim.api.nvim_set_keymap('n', '<F5>', ':UndotreeToggle<CR>', {})
vim.api.nvim_set_keymap('n', '<F8>', ':RainbowParentheses!!<CR>:ColorToggle<CR>', {})

vim.api.nvim_set_keymap('n', '<leader>c', ':Copilot disable<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>e', ':Copilot enable<CR>', {})

vim.api.nvim_set_keymap('n', '<C-p>', ':GFiles<CR>', {})
vim.api.nvim_set_keymap('n', '<C-Tab>', ':bnext<CR>', {})
vim.api.nvim_set_keymap('n', '<C-S-Tab>', ':bprevious<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>q', ':bp|sp|bn|bd<CR>', {})

-- Transparent background and nerdtree highlight configurations
vim.cmd('hi Normal ctermbg=none guibg=none')
vim.cmd('hi CursorLine ctermbg=none guibg=none')

-- Wrap settings
vim.o.whichwrap = vim.o.whichwrap .. '<,>,[,]'
vim.cmd('hi MatchParen ctermbg=none ctermfg=green')

-- Tab and indent settings
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.g.ultisnips_python_style = 'google'

-- Clipboard and mouse settings
vim.o.clipboard = 'unnamedplus'
vim.o.mouse = 'a'

-- Source additional configuration files
vim.cmd('source ~/.nvimrc')

