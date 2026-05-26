return {
  -- Install gruvbox.nvim.
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      -- "soft" | "medium" | "hard"
      contrast = "medium",
      transparent_mode = false,
      bold = true,
      italic = {
        strings = false,
        comments = true,
        operators = false,
        folds = true,
      },
    },
  },

  -- Make LazyVim use it as the default colorscheme.
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
