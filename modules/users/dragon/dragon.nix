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
          agenix
          environment
          editors
          home-manager
        ];
      };
      home-manager.users."${username}".imports = [
        self.modules.homeManager."${username}"
      ];
    }
    {
      homeManager.${username} = {
        imports = with self.modules.homeManager; [
          dragon-packages
          stylix
          shell
          developer
        ];
        home.stateVersion = "25.11";
      };
    }
  ];
}
