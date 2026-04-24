{
  self,
  lib,
  ...
}:
let
  username = "bumblebee";
in
{
  flake.modules = lib.mkMerge [
    (self.lib.user username true)
    {
      nixos.${username} = {
        imports = with self.modules.nixos; [
          basics
          home-manager
        ];
      };
    }
    {
      homeManager.${username} = {
        # imports = with self.modules.homeManager; [];
        home.stateVersion = "25.11";
      };
    }
  ];
}
