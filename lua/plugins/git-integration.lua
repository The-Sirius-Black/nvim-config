return {
    {
        "sindrets/diffview.nvim",
        config = function()
            require("diffview").setup()
        end,
    },
    {
        "tpope/vim-fugitive",
        event = "VimEnter",
    },
}
