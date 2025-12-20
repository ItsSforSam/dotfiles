# vim: ts=2 sw=2 et :
-- return {
--  "folke/neodev.nvim",
--  "folke/which-key.nvim",
--  { "folke/neoconf.nvim", cmd = "Neoconf" },
-- }

return {
  { 'echasnovski/mini.nvim', version = '*' },
  "SmiteshP/nvim-navic",
  {"fgheng/winbar.nvim"},
  "folke/which-key.nvim",
  {"HiPhish/rainbow-delimiters.nvim", version = false},
  {'akinsho/toggleterm.nvim', version = "*", config = true},--, opts = 
{
  size = function(term)
    if term == nil then
      return 20
    elseif term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  -- open_mapping = [[<c-\>]],
  -- on_create = fun(function () vim.cmd("Terminal")),
  -- on_open = fun(function() vim.cmd("Terminal") end ), -- function to run when the terminal opens
  -- on_close = fun("Terminal"), -- function to run when the terminal closes
  -- on_stdout = fun("Terminal", job: number, data: string[], name: string) -- callback for processing output on stdout
  -- on_stderr = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stderr
  -- on_exit = fun(t: Terminal, job: number, exit_code: number, name: string) -- function to run when terminal process exits
  hide_numbers = true, -- hide the number column in toggleterm buffers
  insert_mappings = true,
  terminal_mappings = true,
  shade_terminals = true,
  Normal = {
      -- guibg = "0x",
    },
    NormalFloat = {
      link = 'Normal'
    },
    FloatBorder = {
      -- guifg = "<VALUE-HERE>",
      -- guibg = "<VALUE-HERE>",
    },
  },
},
{
  'mrcjkb/rustaceanvim',
  version = '^6', -- Recommended
  lazy = false, -- This plugin is already lazy
},
"LuaLS/lua-language-server",
-- version = * is for stable
{ 'echasnovski/mini.nvim', version = "*" },
"CarloWood/neovim-true-color-scheme-editor",
-- require('lazy').setup({
 {'glepnir/nerdicons.nvim', cmd = 'NerdIcons', config = function() require('nerdicons').setup({}) end},
-- })
  {
	"hrsh7th/nvim-cmp",
	version = false, -- last reloase is too old
   dependencies = {
    "hrsh7th/cmp-nvim-lsp",
   "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    },
  },
  
  -- Not all LSP servers add brackets when completing a function.
  -- To better deal with this, LazyVim adds a custom option to cmp,
  -- that you can configure. For example:
  --
  -- ```lua
  -- opts = {
  --   auto_brackets = { "python" }
  -- }
  -- ```
  opts  = {
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
    local cmp = require("cmp")
    local defaults = require("cmp.config.default")()
    local auto_select = true
    return {
      auto_brackets = {}, -- configure any filetype to auto add brackets
      completion = {
        completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
      },
      preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = LazyVim.cmp.confirm({ select = auto_select }),
        ["<C-y>"] = LazyVim.cmp.confirm({ select = true }),
        ["<S-CR>"] = LazyVim.cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<C-CR>"] = function(fallback)
          cmp.abort()
          fallback()
        end,
        ["<tab>"] = function(fallback)
          return LazyVim.cmp.map({ "snippet_forward", "ai_accept" }, fallback)()
        end,
      }),
      sources = cmp.config.sources({
        { name = "lazydev" },
        { name = "nvim_lsp" },
        { name = "path" },
      }, {
        { name = "buffer" },
      }),
      formatting = {
        format = function(entry, item)
          local icons = LazyVim.config.icons.kinds
          if icons[item.kind] then
            item.kind = icons[item.kind] .. item.kind
          end

          local widths = {
            abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
            menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
          }

          for key, width in pairs(widths) do
            if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
              item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
            end
          end

          return item
        end,
      },
      experimental = {
        -- only show ghost text when we show ai completions
        ghost_text = vim.g.ai_cmp and {
          hl_group = "CmpGhostText",
        } or false,
      },
      sorting = defaults.sorting,
    }
  end, -- nvim-comp#opt
  main = "lazyvim.util.cmp",
}
