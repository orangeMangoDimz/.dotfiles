-- -- load defaults i.e lua_lsp
-- require("nvchad.configs.lspconfig").defaults()
--
-- local lspconfig = require "lspconfig"
--
-- -- EXAMPLE
-- -- add vue
-- local servers = { "html", "cssls", "pyright", "ts_ls", "vls", "volar", "clangd", "yamlls" }
-- local nvlsp = require "nvchad.configs.lspconfig"
--
-- --NOTE: use `npm install yaml-language-server` to install yamlls and `sudo npm install -g prettier` to install prettier
--
-- -- lsps with default config
-- for _, lsp in ipairs(servers) do
--     lspconfig[lsp].setup {
--         on_attach = nvlsp.on_attach,
--         on_init = nvlsp.on_init,
--         capabilities = nvlsp.capabilities,
--         languageFeatures = {
--             completion = true,
--             semanticTokens = true,
--             references = true,
--             definition = true,
--             diagnostic = true,
--             codeAction = true,
--             documentHighlight = true,
--             documentLink = true,
--             hover = true,
--             rename = true,
--             signatureHelp = true,
--             codeLens = true,
--         },
--     }
-- end
--
-- -- Hybrid TS vue config
-- local mason_registry = require "mason-registry"
-- -- local vue_language_server_path = mason_registry
-- --     .get_package("vue-language-server")
-- --     :get_install_path() .. "/node_modules/@vue/language-server"
--
-- -- lspconfig.ts_ls.setup {
-- --     init_options = {
-- --         plugins = {
-- --             {
-- --                 name = "@vue/typescript-plugin",
-- --                 location = vue_language_server_path,
-- --                 languages = { "vue" },
-- --             },
-- --         },
-- --     },
-- --     filetypes = {
-- --         "typescript",
-- --         "javascript",
-- --         "javascriptreact",
-- --         "typescriptreact",
-- --         "vue",
-- --     },
-- -- }
--
-- lspconfig.volar.setup {
--     init_options = {
--         vue = {
--             hybridMode = false,
--         },
--     },
-- }






-- GEMINI
---- require("nvchad.configs.lspconfig").defaults() -- This is often loaded by NvChad already

local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"

-- Define your list of language servers
-- NOTE: 'tsserver' is the correct name for the TypeScript LSP.
-- NOTE: Removed 'vls' (Vetur) as 'volar' is the modern standard for Vue.
local servers = {
  "html",
  "cssls",
  "pyright",
  "ts_ls", -- Correct name for TypeScript LSP
  "volar",    -- Modern Vue LSP
  "clangd",
  "yamlls",
}

-- Setup servers with NvChad's default settings
for _, server_name in ipairs(servers) do
  local server_opts = {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }

  -- You can add server-specific settings here if needed
  if server_name == "volar" then
    -- 'hybridMode = false' tells volar to handle everything for .vue files.
    -- This is the recommended modern setup.
    server_opts.init_options = {
      vue = {
        hybridMode = false,
      },
    }
  elseif server_name == "ts_ls" then
    -- Add any specific tsserver settings here.
    -- For example, to disable inlay hints:
    -- server_opts.settings = {
    --   typescript = {
    --     inlayHints = {
    --       parameterNames = { enabled = "none" },
    --       parameterTypes = { enabled = "none" },
    --     },
    --   },
    -- }
  end

  lspconfig[server_name].setup(server_opts)
end
