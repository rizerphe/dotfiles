-- Lightline configuration
vim.cmd('source ~/.config/nvim/config/nord_transparent.vim')
vim.g.lightline = {
  colorscheme = 'nord_transparent',
  active = {
    left = { {'mode', 'paste'}, {'gitbranch', 'filename', 'modified'} },
  },
  tabline = {
    left = { {'buffers'} },
    right = {},
  },
  tab = {
    active = {'filename', 'modified'},
    inactive = {'filename', 'modified'},
  },
  component_expand = {
    buffers = 'lightline#bufferline#buffers',
  },
  component_type = {
    buffers = 'tabsel',
  },
  component_function = {
    gitbranch = 'FugitiveHead',
  },
  separator = { left = '', right = '' },
  subseparator = { left = '', right = '' },

  component_raw = {
    buffers = 1
  },
}
vim.g['lightline#bufferline#clickable'] = 1
vim.api.nvim_exec([[
  autocmd BufWritePost,TextChanged,TextChangedI * call lightline#update()
]], false)
