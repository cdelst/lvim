local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set("n", "l", api.node.open.edit, opts "Open")
  vim.keymap.set("n", "h", api.node.navigate.parent_close, opts "Close Directory")
  vim.keymap.set("n", "v", api.node.open.vertical, opts "Open: Vertical Split")
  vim.keymap.del("n", "<C-k>", { buffer = bufnr })
  vim.keymap.set("n", "<S-k>", api.node.open.preview, opts "Open Preview")
end

-- lvim.builtin.lir.icon = ""

lvim.builtin.nvimtree.setup.on_attach = my_on_attach
lvim.builtin.nvimtree.setup.view.centralize_selection = true
lvim.builtin.nvimtree.setup.renderer.icons.glyphs.folder.arrow_open = ""
lvim.builtin.nvimtree.setup.renderer.icons.glyphs.folder.arrow_closed = ""
-- lvim.builtin.nvimtree.setup.renderer.icons.glyphs.folder.open = ""
-- lvim.builtin.nvimtree.setup.renderer.icons.glyphs.folder.default = ""
-- lvim.builtin.nvimtree.setup.renderer.icons.glyphs.folder.empty = ""
-- lvim.builtin.nvimtree.setup.renderer.icons.glyphs.folder.symlink = ""
lvim.builtin.nvimtree.setup.view.centralize_selection = true
-- lvim.builtin.nvimtree.setup.view.cursor = false

-- Related to the below
local HEIGHT_RATIO = 0.8  -- You can change this
local WIDTH_RATIO = 0.5   -- You can change this too

lvim.builtin.nvimtree.setup.view.float = {
  enable = true,
    open_win_config = function()
      local screen_w = vim.opt.columns:get()
      local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
      local window_w = screen_w * WIDTH_RATIO
      local window_h = screen_h * HEIGHT_RATIO
      local window_w_int = math.floor(window_w)
      local window_h_int = math.floor(window_h)
      local center_x = (screen_w - window_w) / 2
      local center_y = ((vim.opt.lines:get() - window_h) / 2)
                         - vim.opt.cmdheight:get()
      return {
            border = 'rounded',
          relative = 'editor',
          row = center_y,
          col = center_x,
          width = window_w_int,
          height = window_h_int,
        }
    end,
  }
  
lvim.builtin.nvimtree.setup.view.width = function()
  return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
end

-- vim.api.nvim_create_autocmd({ 'WinEnter', 'BufWinEnter' }, {
--   pattern = 'NvimTree*',
--   callback = function()
--     local def = vim.api.nvim_get_hl_by_name('Cursor', true)
--     vim.api.nvim_set_hl(0, 'Cursor', vim.tbl_extend('force', def, { blend = 100 }))
--     vim.opt.guicursor:append('a:Cursor/lCursor')
--   end,
-- })

-- vim.api.nvim_create_autocmd({ 'BufLeave', 'WinClosed' }, {
--   pattern = 'NvimTree*',
--   callback = function()
--     local def = vim.api.nvim_get_hl_by_name('Cursor', true)
--     vim.api.nvim_set_hl(0, 'Cursor', vim.tbl_extend('force', def, { blend = 0 }))
--     vim.opt.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20'
--   end,
-- })
