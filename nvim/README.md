# AstroNvim User Config

User overlay for [AstroNvim v5](https://github.com/AstroNvim/AstroNvim).
All customizations live in `init.lua` — the AstroNvim source is unmodified.

## Disabled Plugins

### DAP (Debug Adapter Protocol) — 5 plugins

The entire debugging ecosystem is disabled as a group.

| Plugin | Role in AstroNvim | Lost keybindings |
|--------|-------------------|------------------|
| `mfussenegger/nvim-dap` | Core debugger: breakpoints, stepping, REPL, `.vscode/launch.json` parsing | `<F5>` start, `<F6>` pause, `<F9>` breakpoint, `<F10>` step over, `<F11>` step into, `<Leader>d*` (18 mappings) |
| `rcarriga/nvim-dap-ui` | Sidebar UI for watches, scopes, stacks, hover. Auto-opens on debug start. | `<Leader>du` toggle UI, `<Leader>dE` evaluate, `<Leader>dh` hover |
| `nvim-neotest/nvim-nio` | Async I/O library. Only consumer is nvim-dap-ui. | None (library) |
| `jay-babu/mason-nvim-dap.nvim` | Mason integration for auto-installing debug adapters | `:DapInstall`, `:DapUninstall` commands |
| `rcarriga/cmp-dap` | Completion source for DAP REPL and watch expressions. Adds `dap` provider to blink.cmp. | None (implicit via completion) |

**Effect:** No debugging support. The `<Leader>d` (Debugger) section disappears from which-key.

### None-ls (Linting/Formatting) — 2 plugins

| Plugin | Role in AstroNvim | Lost keybindings |
|--------|-------------------|------------------|
| `nvimtools/none-ls.nvim` | Injects external CLI tools (formatters, linters) as LSP sources. Community fork of null-ls. | `<Leader>lI` Null-ls info |
| `jay-babu/mason-null-ls.nvim` | Mason integration for auto-installing none-ls sources | `:NullLsInstall`, `:NullLsUninstall` commands |

**Effect:** Cannot use CLI-based linters/formatters (eslint, black, stylua, etc.) via the LSP interface. Native LSP formatting from language servers still works. Use a dedicated formatter plugin (e.g. `conform.nvim`) if needed.

### Snippets — 2 plugins

| Plugin | Role in AstroNvim | Lost keybindings |
|--------|-------------------|------------------|
| `L3MON4D3/LuaSnip` | Snippet engine: expand snippets, jump between placeholders | `<Tab>`/`<S-Tab>` snippet forward/backward (in blink.cmp) |
| `rafamadriz/friendly-snippets` | Large collection of pre-made VS Code-style snippets (loaded by LuaSnip) | None (data only) |

**Effect:** No user-defined or community snippet expansion. LSP-driven snippets (e.g. function signature completions) still work via `blink.cmp`'s builtin `vim.snippet` engine — the config overrides `snippets.preset` from `"luasnip"` to `"default"` for this reason.

### Individual Plugins — 9 plugins

#### `stevearc/aerial.nvim`
Code outline / symbol sidebar (like VS Code's outline view).
- **Lost:** `<Leader>lS` toggle outline, `]y`/`[y` next/prev symbol
- **Still works:** `<Leader>ls` (search symbols) — the snacks picker mapping falls back from aerial to `snacks.picker.lsp_symbols()` via a `pcall` guard.

#### `max397574/better-escape.nvim`
Maps `jk`/`jj` in insert mode to `<Esc>` with a 300ms timeout.
- **Lost:** `jk`, `jj` insert-mode escape
- **Alternative:** Use `<Esc>` or `<C-[>` to exit insert mode.

#### `folke/todo-comments.nvim`
Highlights `TODO`, `FIXME`, `HACK` etc. in comments and provides search integration.
- **Lost:** `<Leader>fT` find TODOs, `]T`/`[T` next/prev TODO comment, highlight coloring in comments.

#### `windwp/nvim-ts-autotag`
Auto-closes and auto-renames HTML/JSX/XML tags using treesitter.
- **Lost:** Automatic tag closing/renaming behavior in tag-based filetypes.

#### `mrjones2014/smart-splits.nvim`
Seamless split navigation across Neovim and terminal multiplexers (tmux, wezterm, kitty).
- **Lost:** Cross-multiplexer split navigation.
- **Still works:** `<C-H/J/K/L>` and `<C-Up/Down/Left/Right>` still work for Neovim-internal splits via the default mappings in `_astrocore_mappings.lua`. They just won't cross into tmux/wezterm/kitty panes.

#### `akinsho/toggleterm.nvim`
Floating/split terminal manager and tool launchers (lazygit, python, node, etc.).
- **Lost:** `<F7>` toggle terminal, `<Leader>tf/th/tv` float/horizontal/vertical terminals, `<Leader>gg`/`<Leader>tl` lazygit, `<Leader>tn/tp/tu/tt` node/python/gdu/btm launchers, neo-tree `T/Tf/Th/Tv` open-terminal-here commands.
- **Alternative:** Use `:terminal` or an external terminal.

#### `kevinhwang91/nvim-ufo`
Advanced folding with LSP and treesitter fold providers, fold preview.
- **Lost:** `zR`/`zM` open/close all folds, `zr`/`zm` fold more/less, `zp` peek fold. Also sets fold options (`foldcolumn`, `foldlevel`, `foldenable`).
- **Note:** Already disabled on Neovim 0.11+ by its own spec (`enabled = vim.fn.has "nvim-0.11" ~= 1`). AstroUI provides its own treesitter-based folding via `astroui.folding.foldexpr()` which remains active, using `foldmethod=expr`. Standard fold commands (`za`, `zo`, `zc`) still work if the fold provider generates folds.

#### `NMAC427/guess-indent.nvim`
Analyzes buffer content on file open to auto-detect indent style (tabs vs spaces, width).
- **Lost:** Automatic indent detection per-buffer.
- **Note:** Fires on every `BufReadPost`/`BufNewFile`. Without it, indent settings come from your Neovim defaults or editorconfig.

#### `brenoprata10/nvim-highlight-colors`
Renders inline color swatches for color codes (e.g. `#ff0000` shows a red indicator).
- **Lost:** `<Leader>uz` toggle color highlight, inline color previews.
- **Note:** Fires on every `User AstroFile` and `InsertEnter`. blink.cmp's color highlight integration is `pcall`-guarded and degrades gracefully.

#### `RRethy/vim-illuminate`
Highlights all references to the word under the cursor using LSP/treesitter.
- **Lost:** `]r`/`[r` next/prev reference, `<Leader>ur`/`<Leader>uR` toggle reference highlighting.
- **Note:** Fires on every `User AstroFile`. Queries LSP/treesitter on cursor hold (200ms delay). LSP-based go-to-reference (`gr`) still works without this plugin.

### Other Disabled Specs

| Entry | Reason |
|-------|--------|
| `Saghen/blink.compat` (`enabled=false`) | Compatibility shim only used by `cmp-dap`, which is disabled. |
| `Saghen/blink.cmp` (`snippets.preset = "default"`) | Overrides the `"luasnip"` preset injected by the disabled LuaSnip plugin, so blink.cmp uses Neovim's builtin `vim.snippet` engine instead. |

## Disabled Snacks Sub-Features

`folke/snacks.nvim` itself remains enabled (picker, input, gitbrowse, bigfile, quickfile, zen are active).

| Feature | Role in AstroNvim | Lost keybindings | Notes |
|---------|-------------------|------------------|-------|
| `dashboard` | Startup home screen with quick-access keys (new file, find file, recents, last session) | `<Leader>h` opens dashboard | Neovim opens to an empty buffer instead. `<Leader>h` still triggers the dashboard — it just shows nothing useful. |
| `indent` | Vertical indent guide lines (char `▏`) with buffer filtering | `<Leader>u\|` toggle indent guides | No visual indent guides. |
| `scope` | Highlights the current code scope on the indent guide | None | Visual-only companion to indent. |
| `image` | Inline image rendering in terminal (kitty graphics protocol) | None | AstroNvim configures it for `*.png`, `*.jpg`, `*.gif`, etc. Only works in image-capable terminals (kitty, wezterm). |
| `notifier` | Floating notification popups replacing `vim.notify` with styled UI | `<Leader>uD` dismiss notifications (guarded — mapping not created when disabled) | Notifications fall back to `:messages`. `<Leader>fn` (find notifications) in picker still works for history. |
| `scroll` | Smooth scrolling animation for `<C-D>`, `<C-U>`, `<C-F>`, `<C-B>` and similar scroll commands | None | Enabled by default in snacks.nvim. Adds visual animation overhead to every scroll action. Without it, scrolling is instant (native Neovim behavior). |
| `statuscolumn` | Custom status column (sign column + line numbers + fold indicators) with click handlers | None | Enabled by default in snacks.nvim. Neovim's built-in `statuscolumn` provides the same visual output; this only adds mouse click handlers in the gutter. |
| `words` | Highlights all references to the word under cursor using LSP, with `]]`/`[[` to jump between them | `]]`/`[[` next/prev LSP reference | Enabled by default in snacks.nvim. Functionally equivalent to the disabled `vim-illuminate` plugin. Queries LSP on cursor hold. Without it, LSP-based go-to-reference (`gr`) still works. |
| `explorer` | File explorer sidebar using snacks picker (alternative to neo-tree) | None | Enabled by default in snacks.nvim. Not used by AstroNvim — neo-tree is the configured file explorer (`<Leader>e`). |

## Disabled AstroCore Feature

| Setting | Effect |
|---------|--------|
| `features.notifications = false` | Suppresses the feedback popups shown when toggling AstroNvim features (e.g. "Diagnostics off", "Autopairs on"). The `<Leader>u*` toggles still work, they just don't show visual confirmation. `<Leader>uN` can re-enable notifications at runtime. |

## What Still Works

- **Snacks picker** — `<Leader>ff`, `<Leader>fw`, `<Leader>fg`, all 40+ find/git mappings
- **Snacks input** — `vim.ui.input()` / `vim.ui.select()` handler
- **Snacks gitbrowse** — `<Leader>go`
- **Snacks zen** — `<Leader>uZ`
- **Snacks bigfile** — auto-disables expensive features (treesitter, LSP) for very large files
- **Snacks quickfile** — renders files before lazy.nvim finishes loading for faster perceived open
- **Neo-tree** — `<Leader>e` file explorer
- **LSP** — mason, lspconfig, astrolsp, full language server support
- **Treesitter** — syntax highlighting, text objects, incremental selection
- **Folding** — AstroUI's treesitter-based `foldexpr` (`foldmethod=expr`)
- **blink.cmp** — completion with builtin snippet engine (minus community snippets and DAP sources)
- **Heirline** — statusline and tabline
- **Git signs** — gutter indicators, hunk preview
- **Autopairs** — automatic bracket/quote pairing
- **Which-key** — keybinding popup hints
