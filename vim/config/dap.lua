-- DAP Configuration
local dap = require('dap')
dap.adapters.lldb = {
  type = 'executable',
  command = '/bin/lldb-vscode', -- adjust as needed, must be absolute path
  name = 'lldb'
}

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

local dapui = require('dapui')
dap.listeners.after.event_initialized['dapui_config'] = function()
  dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
  dapui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
  dapui.close()
end
dapui.setup()

-- Key mappings for DAP
local function get_options(desc)
  local options = { noremap = true, silent = true }
  if desc then
    options.desc = desc
  end
  return options
end

local keymap = vim.api.nvim_set_keymap
keymap("n", "zp", ":lua require'dap'.toggle_breakpoint()<CR>", get_options("Debugger: Toggle break[p]oint"))
keymap("n", "ze", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '), nil, vim.fn.input('Log point message: '))<CR>", get_options("Debugger: Set breakpoint with [e]verything: condition and log"))
keymap("n", "zc", ":lua require'dap'.set_breakpoint(vim.fn.input('Condition: '))<CR>", get_options("Debugger: Set [c]onditional breakpoint"))
keymap("n", "zl", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log: '))<CR>", get_options("Debugger: Set [l]og point"))
keymap("n", "zs", ":lua require'dap'.continue()<CR>", get_options("Debugger: [s]tart"))
keymap("n", "zi", ":lua require'dap'.step_into()<CR>", get_options("Debugger: step [i]nto"))
keymap("n", "zo", ":lua require'dap'.step_out()<CR>", get_options("Debugger: step [o]ut"))
keymap("n", "zn", ":lua require'dap'.step_over()<CR>", get_options("Debugger: step [n]ext"))
keymap("n", "zb", ":lua require'dap'.step_back()<CR>", get_options("Debugger: step [b]ack"))
keymap("n", "zt", ":lua require'dap'.terminate()<CR>", get_options("Debugger: [t]erminate"))
keymap("n", "zm", ":lua require('dap-python').test_method()<CR>", get_options("Debugger: test [m]ethod"))
keymap("n", "zr", ":lua require('dap-python').test_class()<CR>", get_options("Debugger: test [r]un whole class"))
