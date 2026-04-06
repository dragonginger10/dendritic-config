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
          editors.alternatives.enable = true;
        };
    }
    {
      homeManager.${username} =
        { pkgs, ... }:
        {
          imports = with self.modules.homeManager; [
            dragon-packages
            shell
          ];
        };
    }
  ];
}
