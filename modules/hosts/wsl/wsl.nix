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
      age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMc+liCDZpVpeDt6cj5UJscoKxqmjKR4vMD6RNV+yAR dragon@wsl";
      imports = with self.modules.nixos; [
        inputs.nixos-wsl.nixosModules.wsl

        base
        nix
        stylix
        determinate
        dragon
        secrets
      ];

      wsl = {
        enable = true;
        defaultUser = config.preferences.user.name;
        useWindowsDriver = true;
        usbip = {
          enable = true;
          autoAttach = [
            "2-2"
          ];
        };
      };

      programs.nix-ld.enable = true;
      environment.localBinInPath = true;

      system.stateVersion = "25.11";
    };
}
