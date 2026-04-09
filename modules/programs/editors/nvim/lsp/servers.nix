{
  flake.modules.nixvim.base.lsp.servers = {
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
}
