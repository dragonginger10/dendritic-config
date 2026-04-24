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
          basic
        ];
      };
    }
    {
      homeManager.${username} = {
        imports = with self.modules.homeManager; [
          shell
        ];
        home.stateVersion = "25.11";
      };
    }
  ];
}
