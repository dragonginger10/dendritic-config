{
  inputs,
  self,
  lib,
  ...
}:
let
  username = "dragon";
in
{
  flake.modules = lib.mkMerge [
    (self.factory.user username true)
    {
      nixos.${username} =
        { pkgs, ... }:
        {
          imports = with self.modules.nixos; [
            environment
            editors
            home-manager
          ];
          preferences.shell.default = pkgs.zsh;
          programs.zsh.enable = true;
          editors.alternatives.enable = true;
        };
    }
    {
      homeManager.${username} =
        { pkgs, ... }:
        {
          imports = with self.modules.homeManager; [
            dragon-packages
          ];
        };
    }
  ];
}
