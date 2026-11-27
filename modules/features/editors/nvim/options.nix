{
  flake.modules.nixvim.base = { pkgs, ... }: {
    globals.mapleader = " ";
    viAlias = true;
    opts = {
      relativenumber = true;
      tabstop = 4;
      softtabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      smartindent = true;
      hlsearch = false;
      incsearch = true;
      termguicolors = true;
      scrolloff = 8;
      updatetime = 50;
      conceallevel = 2;
    };

    extraPlugins =
      let
        nvim-tcss = pkgs.vimUtils.buildVimPlugin {
          name = "nvim-tcss";
          src = pkgs.fetchFromGitHub {
            owner = "cachebag";
            repo = "nvim-tcss";
            rev = "bf9001416158f32fe7e92c42de94de3595aa13e5";
            hash = "sha256-QHY+UzJrFir/gtj7KDzxvSgFfckG+xwGtd6YyDk81lc=";
          };
        };
      in
      [
        nvim-tcss
      ];

    extraConfigLua = ''
      require('tcss').setup({enable = true})
    '';

  };
}
