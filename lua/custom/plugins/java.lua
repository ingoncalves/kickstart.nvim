-- Java (Spring) support: jdtls, Lombok, tests, debugging and Spring Boot Tools
-- Dependencies (nui.nvim, nvim-dap, spring-boot.nvim) come from the plugin's own lazy.lua
return {
  {
    'nvim-java/nvim-java',
    ft = 'java',
    config = function()
      -- The corporate proxy (Zscaler) re-signs HTTPS traffic with a root CA that is only in the
      -- Windows certificate store, not in the JDK's cacerts. Make every Java process started from
      -- Neovim (jdtls, Spring Boot LS, ...) trust the Windows store, or downloads fail with
      -- "PKIX path building failed".
      if vim.fn.has 'win32' == 1 then
        local trust = '-Djavax.net.ssl.trustStoreType=Windows-ROOT'
        local opts = vim.env.JAVA_TOOL_OPTIONS or ''
        if not opts:find(trust, 1, true) then
          vim.env.JAVA_TOOL_OPTIONS = vim.trim(opts .. ' ' .. trust)
        end
      end

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
