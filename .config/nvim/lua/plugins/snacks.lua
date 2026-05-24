return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      -- Include hidden files and directories (those starting with ".")
      -- in all picker sources (files, grep, etc.).
      -- ".git" is still excluded by snacks' default exclude list.
      hidden = true,
      -- Set to true if you also want files ignored by .gitignore to appear.
      ignored = false,
    },
    dashboard = {
      preset = {
        -- Custom NVIM block header shown on the start screen.
        header = [[
███╗   ██╗██╗   ██╗██╗███╗   ███╗
████╗  ██║██║   ██║██║████╗ ████║
██╔██╗ ██║██║   ██║██║██╔████╔██║
██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
        ]],
      },
    },
  },
}
