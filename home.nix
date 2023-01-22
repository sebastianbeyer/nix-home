{ config, pkgs, ... }:

let
  # import extra files
  customNeovim = import ./nixfiles/nvim.nix;
  nvim-snakemake = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/snakemake/snakemake/main/misc/vim/syntax/snakemake.vim";
      # sha256 = "abfb9702b98d887c175ace58f1ab39733dc08d03b674d914f56344ef86e63b61";
  };
  nvim-snakemake-detect = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/snakemake/snakemake/main/misc/vim/ftdetect/snakemake.vim";
  };

in
  {
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    home.username = "sebastian";
    home.homeDirectory = "/home/sebastian";
  
    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    home.stateVersion = "22.05";
  
    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
    targets.genericLinux.enable = true;

    # let Home Manager manage fonts:
    fonts.fontconfig.enable = true;
    
    # gtk = {
    #     enable = true;
    #     # font.name = "Victor Mono SemiBold 12";
    #     theme = {
    #         name = "nordic";
    #         package = pkgs.nordic;
    #     };
    # };
    
    
    home.packages = [
      # pkgs is the set of all packages in the default home.nix implementation
      pkgs.fzf
      pkgs.delta
      pkgs.foot
      pkgs.ripgrep
      pkgs.tmux
      pkgs.mosh
      pkgs.nodejs
      pkgs.black
      # these are needed for neovim system clipboard:
      pkgs.xclip
      pkgs.wl-clipboard
      # fonts
      (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" ]; })
    ];
    
    programs.fish = {
        enable = true;
    };
    programs.git = {
        enable = true;      
        # Additional options for the git program
        package = pkgs.gitAndTools.gitFull; # Install git wiith all the optional extras
        userName = "Sebastian Beyer";
        userEmail = "sebastian.beyer@riseup.net";
        extraConfig = {
          # Use vim as our default git editor
          core.editor = "nvim";
          core.pager = "delta";
          # Cache git credentials for 15 minutes
          credential.helper = "cache";
          init = {
            defaultBranch = "main";
          };
        };
      };

      programs.neovim = customNeovim pkgs;
      # nvim snakemake syntax
      home.file."${config.xdg.configHome}/nvim/syntax/snakemake.vim".source = nvim-snakemake;
      home.file."${config.xdg.configHome}/nvim/ftdetect/snakemake.vim".source = nvim-snakemake-detect;
      
  }


