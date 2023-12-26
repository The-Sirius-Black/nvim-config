return {
    'simrat39/symbols-outline.nvim',
    config = function()
        require("symbols-outline").setup({
            auto_close = true,
            auto_fold = 1,
            symbols = {
                File = {icon = "File: ", hl = "@text.uri"},
                Module = {icon = "Module: ", hl = "@namespace"},
                Namespace = {icon = "Namespace: ", hl = "@namespace"},
                Package = {icon = "Package: ", hl = "@namespace"},
                Class = {icon = "Class: ", hl = "@type"},
                Method = {icon = "Method: ", hl = "@method"},
                Property = {icon = "Property: ", hl = "@method"},
                Field = {icon = "Field: ", hl = "@field"},
                Constructor = {icon = "Constructor: ", hl = "@constructor"},
                Enum = {icon = "Enum: ", hl = "@type"},
                Interface = {icon = "Interface: ", hl = "@type"},
                Function = {icon = "Function: ", hl = "@function"},
                Variable = {icon = "Variable: ", hl = "@constant"},
                Constant = {icon = "Constant: ", hl = "@constant"},
                Number = {icon = "Number: ", hl = "@number"},
                Boolean = {icon = "Boolean: ", hl = "@boolean"},
                Array = {icon = "Array: ", hl = "@constant"},
                Object = {icon = "Object: ", hl = "@type"},
                Key = {icon = "Key: ", hl = "@type"},
                Null = {icon = "Null: ", hl = "@type"},
                EnumMember = {icon = "EnumMember: ", hl = "@field"},
                Struct = {icon = "Struct: ", hl = "@type"},
                Event = {icon = "Event: ", hl = "@type"},
                Operator = {icon = "Operator: ", hl = "@operator"},
                TypeParameter = {icon = "TypeParameter: ", hl = "@parameter"},
                Component = {icon = "Component: ", hl = "@function"},
                Fragment = {icon = "Fragment: ", hl = "@constant"}
            }
        })
        vim.keymap.set('n', '<C-o>', ':SymbolsOutlineOpen<CR>')
    end
}
