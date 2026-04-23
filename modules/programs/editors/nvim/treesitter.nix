{
  flake.modules.nixvim.base =
    { pkgs, ... }:
    {
      plugins.treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
          folding.enable = true;

          grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
            bash
            nix
            markdown
            toml
            lua
            nu
            typst
          ];
        };
      };
    };
}
