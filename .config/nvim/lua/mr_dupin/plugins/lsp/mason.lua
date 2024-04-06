-- https://github.com/williamboman/mason.nvim
return{
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local mason = require("mason")

    local mason_lspconfig = require("mason-lspconfig")

    mason.setup({
      ui = {
        icons = {
          package_installed = "󰅿 ",
          package_pending = "󰦗 ",
          package_uninstalled = "󰭽 ",
        },
      },
    })

    mason_lspconfig.setup({
      ensure_installed = {
        "tsserver",
        "html",
        "htmx",
        "cssls",
        "tailwindcss",
        "svelte",
        "lua_ls",
        "bashls",
        "dockerls",
        "docker_compose_language_service",
        "gopls",
        "markdown_oxide",
        "rust_analyzer",
        "sqls",
        "solang",
        "templ",
        "yamlls",
      },
    })

  end
}
