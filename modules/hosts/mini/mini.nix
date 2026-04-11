{ self, ... }:
{
  nixosHosts.mini.enable = true;
  flake.modules.nixos."confs/mini" =
    {
      config,
    lib,
      ...
    }:
    {
      imports = with self.modules.nixos; [
        nix
        base
        dragon
      ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      system.stateVersion = "25.11";

      boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };

      virtualisation.vmVariant.virtualisation = {
        memorySize = 4096;
        cores = 4;
      };

      services.xserver = {
        enable = true;
        desktopManager.lxqt.enable = true;
        displayManager.lightdm.enable = true;
      };
    };

}
