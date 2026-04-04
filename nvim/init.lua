local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=v15.14.0", lazypath })
end
vim.opt.rtp:prepend(lazypath)

vim.g.icons_enabled = os.getenv("icon") ~= "f"

require("lazy").setup({
  -- 1. Keep AstroNvim core
  { "AstroNvim/AstroNvim", version = "^5", import = "astronvim.plugins" },

  -- 2. Add your custom plugin snippet here
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    keys = {
      { "<leader>aa", nil, desc = "Claude Code" },
      { "<leader>aac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>aaf", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>aar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aaC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      -- { "<leader>aam", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>aab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>aas", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>aas",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },
      -- Diff management
      { "<leader>aaa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>aad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },
  {
    "chanwutk/cursor-cli.nvim",
    name = "cursor-cli",
    branch = "cursor-cli",
    dependencies = { "folke/snacks.nvim" },
    -- Note: config is optional - commands are auto-registered!
    -- You can omit config entirely for defaults:
    -- (no config needed)
    
    -- Or customize with config:
    config = function()
      require("cursor-cli").setup({
        -- your custom config here
      })
    end,
    
    keys = {
      { "<leader>ac", nil, desc = "Cursor CLI" },
      { "<leader>acc", "<cmd>CursorCLI<cr>", desc = "Focus Cursor" },
      { "<leader>acC", "<cmd>CursorCLIClose<cr>", desc = "Close Cursor" },
      { "<leader>acb", "<cmd>CursorCLIAdd %<cr>", desc = "Add current buffer" },
      { "<leader>acs", "<cmd>CursorCLISend<cr>", mode = "v", desc = "Send to Cursor" },
      {
        "<leader>act",
        "<cmd>CursorCLITreeAdd<cr>",
        desc = "Add from tree",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },
    },
  },

  {
    "chanwutk/coding-agents.nvim",
    branch = "codex",
    dependencies = { "folke/snacks.nvim" },
    opts = {
      terminal_cmd = "codex",
      log_level = "info",
      focus_after_send = true,
      track_selection = false,
      terminal = {
        provider = "auto", -- "auto", "snacks", "native", "external", "none", or custom table
        split_side = "right",
        split_width_percentage = 0.30,
      },
    },
    config = function(_, opts)
      vim.g.codex_user_config = opts
      require("codex").setup(opts)
    end,
    keys = {
      { "<leader>ao", nil, desc = "AI / Codex" },
      -- Terminal
      { "<leader>aoc", "<cmd>Codex<cr>", desc = "Toggle / focus Codex terminal" },
      { "<leader>aoo", "<cmd>CodexOpen<cr>", desc = "Open Codex terminal" },
      { "<leader>aox", "<cmd>CodexClose<cr>", desc = "Close Codex terminal" },
      { "<leader>aof", "<cmd>CodexFocus<cr>", desc = "Focus / toggle Codex terminal" },
      -- Context (@path and selection)
      { "<leader>aob", "<cmd>CodexAdd %<cr>", desc = "Add current buffer path to Codex" },
      { "<leader>aos", "<cmd>CodexSend<cr>", mode = "v", desc = "Send visual selection" },
      {
        "<leader>aos",
        "<cmd>CodexTreeAdd<cr>",
        desc = "Add selected path from file tree",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },
    },
  },

  -- 3. Disabled plugins
  { "stevearc/aerial.nvim", enabled=false },
  { "max397574/better-escape.nvim", enabled=false },
  { "folke/todo-comments.nvim", enabled=false },
  { "windwp/nvim-ts-autotag", enabled=false },
  { "mrjones2014/smart-splits.nvim", enabled=false },
  { "rafamadriz/friendly-snippets", enabled=false },
  { "L3MON4D3/LuaSnip", enabled=false },
  { "jay-babu/mason-nvim-dap.nvim", enabled=false },
  { "mfussenegger/nvim-dap", enabled=false },
  { "rcarriga/nvim-dap-ui", enabled=false },
  { "akinsho/toggleterm.nvim", enabled=false },
  { "jay-babu/mason-null-ls.nvim", enabled=false },
  { "nvimtools/none-ls.nvim", enabled=false },
  { "rcarriga/cmp-dap", enabled=false },
  { "nvim-neotest/nvim-nio", enabled=false },
  { "kevinhwang91/nvim-ufo", enabled=false },      -- fancy folding
  { "NMAC427/guess-indent.nvim", enabled=false },  -- auto indent detection
  { "brenoprata10/nvim-highlight-colors", enabled=false },  -- color swatches (show color next to color string like #ff0000 as red)
  -- { "RRethy/vim-illuminate", enabled=false },     -- reference highlighting
  -- { "rebelot/heirline.nvim", enabled=false },

  -- Disable unused Snacks features
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = { enabled = false },
      indent = { enabled = false },
      scope = { enabled = false },
      image = { enabled = false },
      notifier = { enabled = false },
      scroll = { enabled = false },  -- smooth scroll
      statuscolumn = { enabled = false },
      words = { enabled = false },  -- like vim-illuminate
      explorer = { enabled = false },  -- already have neo-tree
    },
  },

  -- Disable notification popups
  {
    "AstroNvim/astrocore",
    opts = {
      features = {
        notifications = false,
      },
      options = {
        opt = {
          timeoutlen = 0,
        },
      },
    },
  },

  -- Override blink.cmp: use builtin snippets instead of disabled LuaSnip
  {
    "Saghen/blink.cmp",
    opts = { snippets = { preset = "default" } },
  },

  -- Disable blink.compat (only used by disabled cmp-dap)
  { "Saghen/blink.compat", enabled = false },

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

