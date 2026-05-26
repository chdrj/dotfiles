-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up (centered)" })
map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "Prev search result (centered)" })

map("v", "<", "<gv", { desc = "Indent left, keep selection" })
map("v", ">", ">gv", { desc = "Indent right, keep selection" })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

map("x", "<leader>p", [["_dP]], { desc = "Paste without yanking" })
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
map({ "n", "v" }, "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })
map({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete to black hole" })
