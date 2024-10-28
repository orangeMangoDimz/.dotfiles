-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
-- add vue
local servers = { "html", "cssls", "pyright", "ts_ls", "vls" }
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
