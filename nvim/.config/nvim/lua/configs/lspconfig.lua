require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "clangd", "pyright", "yamlls", "jsonls" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers

vim.lsp.config("yamlls", {
  settings = {
    yaml = {
      schemas = {
        ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = ".gitlab-ci.yml",
      },
    },
  },
})
