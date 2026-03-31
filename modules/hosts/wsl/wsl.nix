{
  inputs,
  self,
  lib,
  ...
}:
{
  nixosHosts.wsl.enable = true;
  flake-file.inputs.nixos-wsl.url = lib.mkDefault "github:nix-community/NixOS-WSL";

  flake.modules.nixos."confs/wsl" =
    { config, ... }:
    {
      nixpkgs.hostPlatform = "x86_64-linux";
      imports = [
        inputs.nixos-wsl.nixosModules.wsl

        self.modules.nixos.base
        self.modules.nixos.nix
      ];

      wsl = {
        enable = true;
        defaultUser = config.preferences.user.name;
      };

      system.stateVersion = "25.11";
    };
}
