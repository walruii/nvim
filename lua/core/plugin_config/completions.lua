local cmp = require("cmp")

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-o>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  }),
})
local ls = require "luasnip"
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node


ls.add_snippets(nil, {
    all = {
        snip({
            trig = "cmakecpp",
            namr = "cmakecpp",
            dscr = "cmake boiler for cpp",
        }, {
            text {"cmake_minimum_required(VERSION 3.10)",
                    "set(CMAKE_CXX_STANDARD 17)",
                    "set(CMAKE_CXX_STANDARD_REQUIRED ON)",
                    "set(CMAKE_EXPORT_COMPILE_COMMANDS ON)",
                    "# add_library(lib STATIC lib/)",
                    "# target_include_directories(lib PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/lib/include)",
                    "",
                    "project(PROJECT VERSION 1.0)",
                    "add_executable(main src/main.cpp)",
                    "# target_include_directories(main PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)",
                    "# target_link_libraries(main PUBLIC lib)"},
            insert(0),
        }),
        snip({
            trig = "cmakec",
            namr = "cmakec",
            dscr = "cmake boiler for c",
        }, {
            text {"cmake_minimum_required(VERSION 3.10)",
                    "set(CMAKE_EXPORT_COMPILE_COMMANDS ON)",
                    "# add_library(lib STATIC lib/)",
                    "# target_include_directories(lib PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/lib/include)",
                    "",
                    "project(PROJECT C)",
                    "add_executable(main src/main.c)",
                    "# target_include_directories(main PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)",
                    "# target_link_libraries(main PUBLIC lib)"},
            insert(0),
        }),
    },
})
