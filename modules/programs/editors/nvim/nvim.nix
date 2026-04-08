{ lib, inputs, ... }:
{

  flake-file.inputs.nixvim = {
    url = lib.mkDefault "github:nix-community/nixvim";
    nixpkgs.follows = "nixpkgs";
  };

  perSystem.packages.neovim =
    { pkgs, ... }:
    let
      nixvim' = inputs.nixvim.legacyPackages.${pkgs.stdenv.hostPlatform.system};
      nvim = nixvim'.makeNixvim {
        globals.mapleader = " ";
        viAlias = true;
        opts = {
          relativenumber = true;
          tabstop = 4;
          softabstop = 4;
          shiftwidth = 4;
          expandtab = true;
          smartindent = true;
          hlsearch = false;
          incsearch = true;
          terguicolors = true;
          scrolloff = 8;
          updatetime = 50;
          conceallevel = 2;
        };

        plugins = {
          bufferline.enable = true;
          direnv.enable = true;
          drpbar.enable = true;
          hop.enable = true;
          harpoon.enable = true;
          intellitab.enable = true;
          lazygit.enable = true;
          lint.enable = true;
          lualine.enable = true;
          noice.enable = true;
          none-ls.enable = true;
          nvim-autopairs.enable = true;
          webdevicons.enable = true;
          yazi.enable = true;
          startify.enable = true;
        };
        keymaps = { };
        lsp.servers = {
          nushell.enable = true;
          just.enable = true;

          nixd = {
            enable = true;
            config = {
              nixpkgs.expr = "import <nixpkgs> { }";
              formatting.command = "nixfmt";
              options = {
                nixos.expr = "(builtins.getFlake (toString ./.)).nixosConfiguration.wsl.options";
              };
            };
          };
        };
      };
    in
    {
      inherit nvim;
      default = nvim;
    };

}
