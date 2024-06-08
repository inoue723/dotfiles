return {
  -- add vscode theme
  { "Mofiqul/vscode.nvim" },

  -- Configure LazyVim to load vscode theme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "vscode",
    },
  },
}
