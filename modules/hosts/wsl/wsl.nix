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
    { config, pkgs, ... }:
    {
      nixpkgs.hostPlatform = "x86_64-linux";
      imports = with self.modules.nixos; [
        inputs.nixos-wsl.nixosModules.wsl

        base
        nix
        stylix
        determinate
        dragon
      ];

      wsl = {
        enable = true;
        defaultUser = config.preferences.user.name;
        useWindowsDriver = true;
      };

      programs.nix-ld.enable = true;
      environment.localBinInPath = true;

      system.stateVersion = "25.11";
    };
}
