-- vim.cmd([[
-- try
  -- colorscheme onedark
-- catch /^Vim\%((\a\+)\)\=:E185/
  -- colorscheme default
  -- set background=dark
-- endtry]])
--
--
-- Lua
require('onedark').setup {
    style = 'darker'
}
require('onedark').load()
