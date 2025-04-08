-- Git integration plugins
return {
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  {
    'ruifm/gitlinker.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitlinker').setup()
    end,
  },
}
