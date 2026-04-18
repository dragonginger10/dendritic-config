{
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
    (self.lib.user username true)
    {
      nixos.${username} = {
        imports = with self.modules.nixos; [
          environment
          editors
          home-manager
        ];
      };
    }
    {
      homeManager.${username} = {
        #set to new behaviour for gtk
        gtk.gtk4.theme = null;
        imports = with self.modules.homeManager; [
          dragon-packages
          nix
          stylix
          shell
        ];
        home.stateVersion = "25.11";
      };
    }
  ];
}
