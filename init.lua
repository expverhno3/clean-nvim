vim.opt.mouse = "a"

vim.opt.clipboard = "unnamedplus"

vim.opt.undofile = true

vim.opt.ignorecase = true

vim.opt.cursorline = true

vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd('InsertLeave', {
  callback = function()
    vim.fn.VSCodeNotify('hideSuggestWidget')
    vim.fn.VSCodeNotify('closeParameterHints')
    vim.fn.VSCodeNotify('editor.action.inlineSuggest.hide')
  end,
})

vim.api.nvim_create_autocmd('InsertEnter', {
  callback = function()
    vim.fn.VSCodeNotify('editor.action.inlineSuggest.trigger')
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
-- easy change windows focus
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { silent = true })
vim.api.nvim_set_keymap("x", "<C-h>", "<C-w>h", { silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { silent = true })
vim.api.nvim_set_keymap("x", "<C-l>", "<C-w>l", { silent = true })

--- easy change editor focus (pair with vscode keybindings)
vim.api.nvim_set_keymap("n", "<C-j>", ':call VSCodeNotify("workbench.action.nextEditorInGroup")<CR>', { silent = true })
vim.api.nvim_set_keymap("x", "<C-j>", ':call VSCodeNotify("workbench.action.nextEditorInGroup")<CR>', { silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", ':call VSCodeNotify("workbench.action.previousEditorInGroup")<CR>', { silent = true })
vim.api.nvim_set_keymap("x", "<C-k>", ':call VSCodeNotify("workbench.action.previousEditorInGroup")<CR>', { silent = true })

--- easy change editor group size
vim.api.nvim_set_keymap("n", "<C-w><", ':call VSCodeNotify("workbench.action.decreaseViewWidth")<CR>', { silent = true })
vim.api.nvim_set_keymap("x", "<C-w><", ':call VSCodeNotify("workbench.action.decreaseViewWidth")<CR>', { silent = true })
vim.api.nvim_set_keymap("n", "<C-w>>", ':call VSCodeNotify("workbench.action.increaseViewWidth")<CR>', { silent = true })
vim.api.nvim_set_keymap("x", "<C-w>>", ':call VSCodeNotify("workbench.action.increaseViewWidth")<CR>', { silent = true })

-- which key
vim.api.nvim_set_keymap("n", "<Space>", ':call VSCodeNotify("whichkey.show")<CR>', { silent = true })
vim.api.nvim_set_keymap("x", "<Space>", ':call VSCodeNotify("whichkey.show")<CR>', { silent = true })

vim.api.nvim_set_keymap("v", "<", "<gv", { silent = true })
vim.api.nvim_set_keymap("v", ">", ">gv", { silent = true })

-- avoiod copy after delete
vim.api.nvim_set_keymap('n', 'd', '"_d', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'dd', '"_dd', { noremap = true, silent = true })

-- Map x and X to cut (delete and yank to clipboard)
vim.api.nvim_set_keymap('n', 'x', 'd', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'xx', 'dd', { noremap = true, silent = true })

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
            multi_window = false,
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