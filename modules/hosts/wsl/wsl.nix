{
  self,
  inputs,
  lib,
  ...
}:
{
  flake-file.inputs.nixos-wsl.url = lib.mkDefault "github:nix-community/NixOS-WSL";

  nixosHosts.wsl.enable = true;

  # flake.nixosConfigurations.wsl = lib.nixosSystem {
  #   modules = [ self.modules.nixos."confs/wsl" ];
  # };

  flake.modules.nixos."confs/wsl" =
    { pkgs, config, ... }:
    {
      nixpkgs.hostPlatform = "x86_64-linux";
      imports = [
        inputs.nixos-wsl.nixosModules.wsl
        self.modules.nixos.base
        self.modules.nixos.environment
      ];

      wsl = {
        enable = true;
        defaultUser = config.preferences.user.name;
      };

      system.stateVersion = "25.11";
    };
}
