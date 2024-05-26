-- require("ibl").setup {
--   indent = {}
-- }

-- -- for example, context is off by default, use this to turn it on
-- show_current_context = true,
-- show_current_context_start = true,
local highlight = {
  "CursorColumn",
  "Whitespace",
}

require("ibl").setup {
  indent = { highlight = highlight, char = "" },

  whitespace = {
    highlight = highlight,
    remove_blankline_trail = false,
  },
  scope = { enabled = false },
}
