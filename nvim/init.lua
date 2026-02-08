local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- 1. Keep AstroNvim core
  { "AstroNvim/AstroNvim", version = "^5", import = "astronvim.plugins" },

  -- 2. Add your custom plugin snippet here
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    keys = {
      { "<leader>a", nil, desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },

  -- 3. Disabled plugins
  { "stevearc/aerial.nvim", enabled=false },
  { "max397574/better-escape.nvim", enabled=false },
  { "folke/todo-comments.nvim", enabled=false },
  -- { "rebelot/heirline.nvim", enabled=false },
  { "windwp/nvim-ts-autotag", enabled=false },
  { "mrjones2014/smart-splits.nvim", enabled=false },
  { "rafamadriz/friendly-snippets", enabled=false },
  { "L3MON4D3/LuaSnip", enabled=false },
  { "jay-babu/mason-nvim-dap.nvim", enabled=false },
  { "mfussenegger/nvim-dap", enabled=false },
  { "rcarriga/nvim-dap-ui", enabled=false },
  { "akinsho/toggleterm.nvim", enabled=false },
  { "brenoprata10/nvim-highlight-colors", enabled=false },

  -- 4. Change background color to black
  {
    "AstroNvim/astrotheme",
    opts = {
      palettes = {
        astrodark = {
          ui = {
            base = "#000000",
            inactive_base = "#0a0a0a",
            highlight = "#444444"
          },
        },
      },
    },
  },
})

