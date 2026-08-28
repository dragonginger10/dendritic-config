{
  flake.modules.nixvim.base.lsp.servers = {
    nushell.enable = true;
    just.enable = true;
    bashls.enable = true;
    ruff.enable = true;
    gopls.enable = true;
    lua_ls.enable = true;
    elixirls.enable = true;
    texlab.enable = true;

    tinymist = {
      enable = true;
      config = {
        formatterMode = "typstyle";
      };
    };

    nixd = {
      enable = true;
      config = {
        nixpkgs.expr = "import <nixpkgs> { }";
        formatting.command = "nixfmt";
        options = {
          nixos.expr = "(builtins.getFlake (toString ./.)).nixosConfiguration.phos.options";
        };
      };
    };
  };
}
