vim.g.mapleader = ' '
vim.g.maplocalleader = '  '

require('custom.maps')
require('custom.opts')
require('custom.pack').setup('custom/plugins')
