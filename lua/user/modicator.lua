require("modicator").setup {
  -- Show warning if any required option is missing
  show_warnings = true,
  highlights = {
    -- Default options for bold/italic
    defaults = {
      bold = false,
      italic = false,
    },
  },
  integration = {
    lualine = {
      enabled = true,
      -- Letter of lualine section to use (if `nil`, gets detected automatically)
      mode_section = nil,
      -- Whether to use lualine's mode highlight's foreground or background
      highlight = "bg",
    },
  },
}

vim.api.nvim_create_autocmd({ "Colorscheme" }, {
  callback = function()
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#388bfd", bg = "NONE" })
  end,
})

lvim.o.number = true
lvim.o.termguicolors = true
lvim.o.cursorline = true
