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
  homeConfigs.${username}.enable = true;
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
          #set to new behaviour for gtk
          gtk.gtk4.theme = null;
          imports = with self.modules.homeManager; [
            dragon-packages
            shell
          ];
          home.stateVersion = "25.11";
        };
    }
  ];
}
