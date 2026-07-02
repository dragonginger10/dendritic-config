{
  self,
  lib,
  ...
}:
let
  username = "kongo";
in
{
  homeConfigs.${username}.enable = true;
  flake.modules = lib.mkMerge [
    (self.lib.user username true)
    {
      nixos.${username} = {
        imports = with self.modules.nixos; [
          basic
          editors
          home-manager
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
