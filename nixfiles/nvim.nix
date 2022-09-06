pkgs:

{
    enable = true;
    vimAlias = true;
    extraConfig = ''
        luafile $HOME/.config/nixpkgs/nixfiles/init.lua
    '';

    # this install the plugins without additional plugin manager
    plugins = with pkgs.vimPlugins; [
        vim-nix
        indentLine
        plenary-nvim
        {
            plugin = indent-blankline-nvim;
            config = "lua require('indent_blankline').setup()";
        }
        {
            plugin = nord-nvim;
            config = "colorscheme nord";
        }
        {
            plugin = lualine-nvim;
            config = "lua require('lualine').setup()";
        }
        {
            plugin = bufferline-nvim;
            config = ''
            lua << EOF
                vim.opt.termguicolors = true
                require("bufferline").setup{}
            EOF
                '';
        }
        {
            plugin = telescope-nvim;
            config = "lua require('telescope').setup()";
        }
        telescope-fzf-native-nvim
        nvim-web-devicons
        vim-commentary
        {
            plugin = nvim-treesitter;
            config = ''
            lua << EOF
            require('nvim-treesitter.configs').setup {
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            }
            EOF
            '';
        }
        coc-nvim
        coc-pyright
        {
            plugin = gitsigns-nvim;
            config = "lua require('gitsigns').setup()";
        }
    ];
}
