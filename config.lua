-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "catppuccin"

vim.g.catppuccin_flavour = "mocha"
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

vim.o.timeoutlen = 500
vim.cmd("set relativenumber")
vim.cmd("set foldmethod=indent   ")
vim.cmd("set foldnestmax=10")
vim.cmd("set nofoldenable")
vim.cmd("set foldlevel=2")
-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- accidentally hitting this too much, using leader q instead
-- lvim.keys.normal_mode["q"] = ":q<cr>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<M-A>"] = "<Plug>(copilot-select)"
lvim.keys.normal_mode["<TAB>"] = ":bnext<CR>"
lvim.keys.normal_mode["<S-TAB>"] = ":bprevious<CR>"
vim.api.nvim_set_keymap("i", "<A-\\>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

-- Telescope
lvim.builtin.telescope.defaults.file_ignore_patterns = {
  "node_modules",
  "bower_components",
  "chrome_devtools",
  ".vercel",
  "build",
  "dist",
  ".git",
  ".svelte-kit",
}


-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
}

lvim.builtin.which_key.mappings["T"] = {
  name = "+Terminal",
  d = { "<cmd>TermExec cmd=\"npm run dev\"<cr>", "npm run dev" },
}

lvim.builtin.which_key.mappings["S"] = {
  name = "+Sessions",
  s = { "<cmd>:Telescope session-lens search_session<cr>", "Search" },
}

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" } },
  { command = "isort", filetypes = { "python" } },
  {
    -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "prettier",
    ---@usage arguments to pass to the formatter
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "typescript", "typescriptreact", "html", "css", "xml", "yml", "javascript" },
  },
}

-- -- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "flake8", filetypes = { "python" } },
  {
    -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "shellcheck",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--severity", "warning" },
  },
  {
    command = "eslint",
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "javascript", "typescript", "typescriptreact" },
  },
}



-- Additional Plugins
lvim.plugins = {
  { "github/copilot.vim" },
  { "kylechui/nvim-surround" },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    "Theprimeagen/vim-be-good",
  },
  {
    "rmagatti/auto-session",
    auto_restore_enabled = false
  },
  { "rmagatti/session-lens" },
  { "tpope/vim-sleuth" },
  { 'catppuccin/nvim', as = 'catpuccin' },
  {
    'karb94/neoscroll.nvim',
  },
}

-- Autosession
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

-- Copilot
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
-- vim.g.copilot_tab_fallback = ""

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })


require "neoscroll"
