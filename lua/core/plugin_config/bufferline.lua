    local bufferline = require('bufferline')
    bufferline.setup {
        options = {
            separator_style = "slant",
            mode = "tabs",
            offsets = {
                filetype = "NvimTree",
                text = " File Explorer",
                highlight = "Directory",
                separator = false
            }
        }
    }
