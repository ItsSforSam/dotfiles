
-- https://lazy.folke.io/installation
require("config.lazy") -- .setup("plugins")

require("vim.lsp.health").check()
require("lspconfig")--.lua_ls.setup{}


-- require('mini.icons').setup()

-- require('lazy').setup({
-- {'glepnir/nerdicons.nvim', cmd = 'NerdIcons', config = function() require('nerdicons').setup({}) end}
-- })
--
vim.filetype.add{
  pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
}
vim.opt.number = true
vim.opt.wrap = false
