-- ==================== Keymaps ====================
-- Important! Always set your leader key first before anything.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set({ 'n', 'v' }, '<leader>', '<nop>')
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<cr>', '<cmd>nohl<cr>')
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set('n', '<leader>p', '"+p')
vim.keymap.set('v', 'J', ":m '>+1<cr>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<cr>gv=gv")
vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<cr>')

-- ==================== Options ====================
-- See :h option-list
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.termguicolors = true
vim.opt.scrolloff = 5
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.colorcolumn = '120'
vim.opt.cursorline = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.showbreak = '   '
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.list = true
vim.cmd([[set listchars=tab:→\ ,eol:↲,extends:›,precedes:‹,nbsp:␣,trail:~]])
vim.cmd('au BufEnter * set formatoptions-=o')

-- ==================== Plugins ====================
local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system { 'git', 'clone', '--filter=blob:none', lazyrepo, '--branch=stable', lazypath }
end
vim.opt.rtp:prepend(lazypath)

-- See :h lazy.nvim-lazy.nvim-plugin-spec
require('lazy').setup('plugins', {
	change_detection = {
		notify = false,
	},
})

-- ==================== Autocmds ====================
-- Resize splits if window got resized
vim.api.nvim_create_autocmd({ 'VimResized' }, {
	group = vim.api.nvim_create_augroup('resize_splits', { clear = true }),
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd('tabdo wincmd =')
		vim.cmd('tabnext ' .. current_tab)
	end,
})
