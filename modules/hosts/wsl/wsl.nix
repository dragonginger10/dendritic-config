{ config, ... }:
{
  nixosHosts.wsl.enable = true;

  flake.modules.nixos."confs/wsl" = {
    nixpkgs.hostPlatform = "x86_64-linux";
    # imports = [
    #   inputs.nixos-wsl.nixosModules.wsl
    #   self.modules.nixos.base
    #   self.modules.nixos.environment
    # ];

    wsl = {
      enable = true;
      defaultUser = config.preferences.user.name;
    };

    system.stateVersion = "25.11";
  };
}
