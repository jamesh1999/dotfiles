return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local custom_nord = require("lualine.themes.nord");
        custom_nord.normal.a = { bg = "#81A1C1", fg = "#3B4252", gui = "bold"};
        custom_nord.insert.a = { bg = "#FDB674", fg = "#3B4252", gui = "bold"};
        custom_nord.visual.a = { bg = "#88C0D0", fg = "#3B4252", gui = "bold"};
        custom_nord.replace.a = { bg = "#ECEFF4", fg = "#3B4252", gui = "bold"};
        custom_nord.inactive.a = { bg = "#FDB674", fg = "#3B4252", gui = "bold"};

        custom_nord.normal.b = { bg = "#4C566A", fg = "#E5E9F0"};
        custom_nord.insert.b = { bg = "#4C566A", fg = "#E5E9F0"};
        custom_nord.visual.b = { bg = "#4C566A", fg = "#E5E9F0"};
        custom_nord.replace.b = { bg = "#4C566A", fg = "#E5E9F0"};
        custom_nord.inactive.b = { bg = "#4C566A", fg = "#E5E9F0"};

        custom_nord.normal.c = { bg = "#3B4252", fg = "#E5E9F0"};
        custom_nord.insert.c = { bg = "#3B4252", fg = "#E5E9F0"};
        custom_nord.visual.c = { bg = "#3B4252", fg = "#E5E9F0"};
        custom_nord.replace.c = { bg = "#3B4252", fg = "#E5E9F0"};
        custom_nord.inactive.c = { bg = "#3B4252", fg = "#E5E9F0"};

        require("lualine").setup({
            options = {
                theme = custom_nord,
                section_separators = { left = '', right = '' },
                component_separators = { left = '', right = '' },
            },
            sections = {
                lualine_x = { "filetype" },
                lualine_y = { "encoding", "fileformat" },
                lualine_z = { "location" },
            },
        })
    end
}
