local icons = require("icons").kinds
local luasnip = require "luasnip"
local cmp_buffer = require "cmp_buffer"
local compare = require "cmp.config.compare"

require("lspkind").init {}

lvim.builtin.cmp.window = {
  completion = {
    border = "rounded",
    winhighlight = "Normal:Pmenu,CursorLine:PmenuSel,FloatBorder:FloatBorder,Search:None",
    col_offset = -3,
    side_padding = 1,
    scrollbar = false,
    -- scrollbar = {
    --   position = 'inside',
    -- },
    scrolloff = 8,
  },
  documentation = {
    border = "rounded",
    winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,Search:None",
  },
}
vim.opt.pumblend = 10

lvim.builtin.cmp.formatting = {
  fields = { "kind", "abbr", "menu" },
  format = function(entry, item)
    item.kind = string.format("%s %s", icons[item.kind], item.kind)
    item.menu = ({
      buffer = "[Buffer]",
      luasnip = "[Snip]",
      nvim_lsp = "[LSP]",
      nvim_lua = "[API]",
      path = "[Path]",
      rg = "[RG]",
    })[entry.source.name]
    return item
  end,
}
lvim.builtin.cmp.snippet = {
  expand = function(args)
    luasnip.lsp_expand(args.body)
  end,
}

lvim.builtin.cmp.sorting = {
  comparators = {
    -- Sort by distance of the word from the cursor
    -- https://github.com/hrsh7th/cmp-buffer#locality-bonus-comparator-distance-based-sorting
    function(...)
      return cmp_buffer:compare_locality(...)
    end,
    compare.offset,
    compare.exact,
    compare.score,
    require("cmp-under-comparator").under,
    compare.recently_used,
    compare.locality,
    compare.kind,
    compare.sort_text,
    compare.length,
    compare.order,
  },
}

lvim.builtin.cmp.sources[2].entry_filter = function(entry, ctx)
  local kind = require("cmp.types.lsp").CompletionItemKind[entry:get_kind()]
  if kind == "Snippet" and ctx.prev_context.filetype == "java" then
    return false
  end

  if kind == "Text" and not ctx.prev_context.filetype == "markdown" then
    return false
  end

  return true
end
