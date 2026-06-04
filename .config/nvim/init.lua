-- Neovide launches from the GUI with no terminal cwd, so it starts in ~.
-- Redirect those launches to ~/code (only when opened with no file args).
-- Registered before VimEnter fires; vim.g.neovide is reliably set by then.
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.g.neovide and vim.fn.argc() == 0 and vim.fn.getcwd() == vim.fn.expand("~") then
      vim.fn.chdir(vim.fn.expand("~/code"))
    end
  end,
})

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
