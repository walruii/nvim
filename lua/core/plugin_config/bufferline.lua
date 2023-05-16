    local bufferline = require('bufferline')
    bufferline.setup {
        options = {
            -- separator_style = "slant",
            -- mode = "tabs",
            offsets = {
                filetype = "NvimTree",
                text = " File Explorer",
                text_align = 'left',
                -- highlight = "Directory",
                separator = true
            }
        }
    }
