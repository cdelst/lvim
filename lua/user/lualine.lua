local components = require "lvim.core.lualine.components"

if lvim.colorscheme == "onedark" then
  lvim.builtin.lualine.options.theme = "onedark"

  lvim.builtin.lualine.options = {
    theme = "onedark",
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
    icons_enabled = true,
    path = 1,
  }

  local diagnostics = {
    "diagnostics",

    sources = { "nvim_diagnostic" },
    sections = { "error", "warn" },

    diagnostics_color = {
      error = "Statusline",
      warn = "Statusline",
      info = "Statusline",
      hint = "Statusline",
    },
    symbols = {
      error = lvim.icons.diagnostics.Error .. " ",
      warn = lvim.icons.diagnostics.Warning .. " ",
      info = "I",
      hint = "H",
    },
    colored = true, -- Displays diagnostics status in color if set to true.
    update_in_insert = false, -- Update diagnostics in insert mode.
    always_visible = true, -- Show diagnostics even if there are none.
  }
  local copilot = function()
    local buf_clients = vim.lsp.get_active_clients { bufnr = 0 }
    if #buf_clients == 0 then
      return "LSP Inactive"
    end

    local buf_ft = vim.bo.filetype
    local buf_client_names = {}
    local copilot_active = false

    -- add client
    for _, client in pairs(buf_clients) do
      if client.name ~= "null-ls" and client.name ~= "copilot" then
        table.insert(buf_client_names, client.name)
      end

      if client.name == "copilot" then
        copilot_active = true
      end
    end

    if copilot_active then
      return lvim.icons.git.Octoface
    end
    return ""
  end

  local filetype = function()
    return vim.bo.filetype
  end

  lvim.builtin.lualine.sections.lualine_a = {
    components.branch,
  }

  lvim.builtin.lualine.sections.lualine_b = {
    diagnostics,
    components.python_env,
  }

  lvim.builtin.lualine.sections.lualine_c = {
    { "diff", symbols = { added = " ", modified = "~", removed = " " } },
    {
      "filename",
      path = 1,
      symbols = { modified = " ", readonly = " ", unnamed = " ", newfile = " " },
      newfile_status = true,
    },
  }

  local function location()
    local line = vim.fn.line "."
    local col = vim.fn.virtcol "."
    return string.format("Ln %d,Col %d", line, col)
  end

  lvim.builtin.lualine.sections.lualine_x = {
    location,
  }
  lvim.builtin.lualine.sections.lualine_y = {
    components.spaces,
    copilot,
    filetype,
  }

  lvim.builtin.lualine.sections.lualine_z = {
    components.progress,
  }
end
