-- basics
-- vim.cmd('syntax on')
-- vim.cmd('filetype plugin indent on')
-- vim.opt.number          = true
-- vim.opt.relativenumber  = true
-- vim.opt.termguicolors   = true
-- vim.opt.shiftround      = true
-- vim.opt.updatetime      = 100
-- vim.opt.cursorline      = true
-- vim.opt.autowrite       = true
-- if vim.fn.has('termguicolors') then
    -- vim.opt.termguicolors = true
-- end
-- tabs
-- vim.opt.autoindent      = true
-- vim.opt.tabstop         = 4
-- vim.opt.shiftwidth      = 4
-- vim.opt.softtabstop     = 4
-- vim.opt.expandtab       = true

require("keymaps")
-- require("core.plugins")
-- disable some useless standard plugins to save startup time
-- these features have been better covered by plugins
-- vim.g.loaded_matchparen        = 1
-- vim.g.loaded_matchit           = 1
-- vim.g.loaded_logiPat           = 1
-- vim.g.loaded_rrhelper          = 1
-- vim.g.loaded_tarPlugin         = 1
-- vim.g.loaded_gzip              = 1
-- vim.g.loaded_zipPlugin         = 1
-- vim.g.loaded_2html_plugin      = 1
-- vim.g.loaded_shada_plugin      = 1
-- vim.g.loaded_spellfile_plugin  = 1
-- vim.g.loaded_netrw             = 1
-- vim.g.loaded_netrwPlugin       = 1
-- vim.g.loaded_tutor_mode_plugin = 1
-- vim.g.loaded_remote_plugins    = 1
-- require("core.theme")

-- Load plugin configs
-- plugins without extra configs are configured directly here
-- require("impatient")
-- require("bufferline").setup()

-- require("configs.autocomplete").config()
-- require("configs.statusline").config()
-- require("configs.filetree").config()
require("treesitter").config()

-- nvim-lspconfig config
-- List of all pre-configured LSP servers:
-- github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
require('lspconfig').zls.setup {}
-- local servers = { 'zls' }
-- for _, lsp in pairs(servers) do
    -- require('lspconfig')[lsp].setup {
        -- on_attach = on_attach
    -- }
-- end
-- require("configs.outlinetree").config()
-- require("configs.startscreen").config()

