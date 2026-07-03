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
        preferences.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICsuTYhZ1XsXb+d/Pyph7RpkPYnE3R4xV9Usl5aH6Ood dragon@phos"
        ];
        age.secrets.linode.rekeyFile = ./linode.age;
        imports = with self.modules.nixos; [
          environment
          editors
          home-manager
        ];
      };
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
