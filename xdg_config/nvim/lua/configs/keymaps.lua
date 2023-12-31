local nmap = require("utils.mapper").nmap
local imap = require("utils.mapper").imap
local vmap = require("utils.mapper").vmap
local xmap = require("utils.mapper").xmap

imap("kj", "<esc>")

nmap("j", "gj")
nmap("k", "gk")
nmap("gj", "j")
nmap("gk", "k")

nmap("<C-h>", "<C-w>h")
nmap("<C-j>", "<C-w>j")
nmap("<C-k>", "<C-w>k")
nmap("<C-l>", "<C-w>l")

nmap("<C-u>", "<C-u>zz")
nmap("<C-d>", "<C-d>zz")

nmap("<cr>", "<cmd>nohl<cr><cr>")

vmap("<leader>y", '"+y')
nmap("<leader>p", '"+p')

nmap("<M-j>", "<cmd>m+<cr>==")
nmap("<M-k>", "<cmd>m-2<cr>==")
xmap("<M-j>", ":'<,'>m'>+<cr>gv=gv")
xmap("<M-k>", ":'<,'>m-2<cr>gv=gv")

nmap("<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<cr>")
