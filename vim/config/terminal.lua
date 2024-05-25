-- Open terminal function
function _G.open_terminal(...)
  if select('#', ...) > 0 then
    vim.cmd('terminal ' .. select(1, ...))
  else
    vim.cmd('terminal')
  end
  vim.cmd('setlocal nonumber norelativenumber')
  vim.cmd('set winfixheight')
end

-- Enter terminal mode on mouse click
vim.api.nvim_exec([[
  autocmd TermOpen * nnoremap <buffer><LeftRelease> <LeftRelease>i
]], false)

-- Key mappings for terminal
vim.api.nvim_set_keymap('n', '<F6>', ':belowright 10split<CR>:call v:lua.open_terminal()<CR>A', {})
