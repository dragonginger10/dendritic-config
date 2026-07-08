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
        age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICsuTYhZ1XsXb+d/Pyph7RpkPYnE3R4xV9Usl5aH6Ood dragon@phos";
        secrets = {
          cloudapi = {
            rekeyFile = ./cloudapi.age;
            mode = "770";
            owner = username;
            group = "users";
          };
          linode = {
            rekeyFile = ./linode.age;
            mode = "770";
            owner = username;
            group = "users";
          };
          sshkey = {
            rekeyFile = ./sshkey.age;
            path = "/home/dragon/.ssh/id_ed25519";
            generator.script = "passphrase";
          };
        };
        imports = with self.modules.nixos; [
          agenix
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
