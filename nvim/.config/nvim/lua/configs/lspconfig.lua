-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
-- add vue
local servers = { "html", "cssls", "pyright", "ts_ls", "vls", "volar", "clangd" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = nvlsp.on_attach,
        on_init = nvlsp.on_init,
        capabilities = nvlsp.capabilities,
        languageFeatures = {
            completion = true,
            semanticTokens = true,
            references = true,
            definition = true,
            diagnostic = true,
            codeAction = true,
            documentHighlight = true,
            documentLink = true,
            hover = true,
            rename = true,
            signatureHelp = true,
            codeLens = true,
        },
    }
end

-- Hybrid TS vue config
local mason_registry = require "mason-registry"
local vue_language_server_path = mason_registry
    .get_package("vue-language-server")
    :get_install_path() .. "/node_modules/@vue/language-server"

-- lspconfig.ts_ls.setup {
--     init_options = {
--         plugins = {
--             {
--                 name = "@vue/typescript-plugin",
--                 location = vue_language_server_path,
--                 languages = { "vue" },
--             },
--         },
--     },
--     filetypes = {
--         "typescript",
--         "javascript",
--         "javascriptreact",
--         "typescriptreact",
--         "vue",
--     },
-- }

lspconfig.volar.setup {
  init_options = {
    vue = {
      hybridMode = false,
    },
  },
}
