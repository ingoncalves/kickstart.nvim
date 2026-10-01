-- Java (Spring) support: jdtls, Lombok, tests, debugging and Spring Boot Tools
-- Dependencies (nui.nvim, nvim-dap, spring-boot.nvim) come from the plugin's own lazy.lua
return {
  {
    'nvim-java/nvim-java',
    ft = 'java',
    config = function()
      require('java').setup {
        -- Use the JDK already installed on the system (JAVA_HOME / PATH) instead of downloading one
        jdk = { auto_install = false },
      }

      vim.lsp.config('jdtls', {
        capabilities = require('blink.cmp').get_lsp_capabilities(),
        settings = {
          java = {
            configuration = {
              runtimes = {
                { name = 'JavaSE-21', path = vim.env.JAVA_HOME, default = true },
              },
            },
          },
        },
      })
      vim.lsp.enable 'jdtls'
    end,
  },
}
