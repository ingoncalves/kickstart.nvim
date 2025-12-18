-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  'kevinhwang91/nvim-bqf',
  'andymass/vim-matchup',
  'junegunn/vim-easy-align',
  'preservim/nerdcommenter',
  'tpope/vim-abolish',
  'tpope/vim-repeat',
  'tpope/vim-surround',
  'nvim-treesitter/nvim-treesitter-context',
  'ThePrimeagen/refactoring.nvim',
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require'colorizer'.setup()
    end,
  },
  {
    'Wansmer/treesj',
    keys = { '<space>m', '<space>j', '<space>s' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
    config = function()
      require('treesj').setup()
    end,
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio'}
  }, -- Debugging
}
