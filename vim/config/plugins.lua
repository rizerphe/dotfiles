-- Plugin management using packer.nvim
require('packer').startup(function(use)
  use {'wbthomason/packer.nvim'}
  use {'neoclide/coc.nvim', branch = 'release'}
  use {'preservim/nerdtree'}
  -- use {'sheerun/vim-polyglot'}
  use {'mbbill/undotree'}
  use {'ryanoasis/vim-devicons'}
  use {'Xuyuanp/nerdtree-git-plugin'}
  use {'tiagofumo/vim-nerdtree-syntax-highlight'}
  use {'itchyny/lightline.vim'}
  use {'mengelbrecht/lightline-bufferline'}
  use {'SirVer/ultisnips'}
  use {'honza/vim-snippets'}
  use {'mlaursen/vim-react-snippets'}
  -- use {'jiangmiao/auto-pairs'}
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use {'nvim-treesitter/nvim-treesitter-context'}
  use {'junegunn/fzf', run = function() vim.fn['fzf#install']() end}
  use {'junegunn/fzf.vim'}
  -- use {'arcticicestudio/nord-vim'}
  use {'chrisbra/Colorizer'}
  use {'github/copilot.vim'}
  use {'junegunn/rainbow_parentheses.vim'}
  use {'yaegassy/coc-ruff', run = 'yarn install --frozen-lockfile'}
  -- use {'wellle/context.vim'}
  use {'tpope/vim-fugitive'}
  use {'tikhomirov/vim-glsl'}

  use {'nvim-neotest/nvim-nio'}
  use {'mfussenegger/nvim-dap'}
  use {'rcarriga/nvim-dap-ui'}
end)

require('config.coc')
require('config.dap')
require('config.nerdtree')
require('config.lightline')
require('config.fzf')
require('config.treesitter-context')
