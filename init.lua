vim.opt.mouse = "a"

vim.opt.clipboard = "unnamedplus"

vim.opt.undofile = true

vim.opt.ignorecase = true

vim.opt.cursorline = true

vim.opt.hlsearch = true

vim.opt.formatoptions:remove("c")
vim.opt.formatoptions:remove("r")
vim.opt.formatoptions:remove("o")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- NEW HERE FOR vscode-nvim
vim.api.nvim_set_keymap("x", "gc", "<Plug>VSCodeCommentary", {})
vim.api.nvim_set_keymap("n", "gc", "<Plug>VSCodeCommentary", {})
vim.api.nvim_set_keymap("o", "gc", "<Plug>VSCodeCommentary", {})
vim.api.nvim_set_keymap("n", "gcc", "<Plug>VSCodeCommentaryLine", {})

vim.api.nvim_set_keymap(
	"n",
	"<C-w>",
	':<C-u>call VSCodeNotify("workbench.action.toggleEditorWidths")<CR>',
	{ silent = true }
)
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { silent = true })
vim.api.nvim_set_keymap("x", "<C-h>", "<C-w>h", { silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { silent = true })
vim.api.nvim_set_keymap("x", "<C-l>", "<C-w>l", { silent = true })

vim.api.nvim_set_keymap("n", "<Space>", ':call VSCodeNotify("whichkey.show")<CR>', { silent = true })
vim.api.nvim_set_keymap("x", "<Space>", ':call VSCodeNotify("whichkey.show")<CR>', { silent = true })

vim.api.nvim_set_keymap("v", "<", "<gv", { silent = true })
vim.api.nvim_set_keymap("v", ">", ">gv", { silent = true })

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- NOTE: flash
	{
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s",
        mode = { "n", "x", "o" },
        function() require("flash").jump({
          search = {
            mode = function(str)
              return "\\<" .. str
            end,
          },
        }) end,
        desc = "Flash" },
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
  },

	-- NOTE: use leap
  -- {
  --   "ggandor/leap.nvim",
  --   enabled = true,
  --   config = function(_, opts)
  --     local leap = require("leap")
  --     for k, v in pairs(opts) do
  --       leap.opts[k] = v
  --     end
  --     leap.add_default_mappings(true)
  --     vim.keymap.del({ "x", "o" }, "x")
  --     vim.keymap.del({ "x", "o" }, "X")
  --     vim.keymap.set('n', 's', '<Plug>(leap)')
  --   end,
  -- },
  {
    "tpope/vim-repeat", event = "VeryLazy" 
  }
})

-- flash settings

