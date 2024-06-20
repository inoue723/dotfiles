return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    inlay_hints = {
      enabled = false,
    },
    servers = {
      lua_ls = {},
      prismals = {},
      biome = {
        cmd = { "pnpm", "biome", "lsp-proxy" },
      },
    },
  },
}
