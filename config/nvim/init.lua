-- bootstrap lazy.nvim, LazyVim and your plugins
vim.g.NERDTreeShowHidden=1
vim.api.nvim_set_keymap('n', '<Leader>ff', ':Telescope find_files hidden=true filetype=files<CR>', { noremap = true, silent = true})
vim.o.background = "dark"
require("config.lazy")
