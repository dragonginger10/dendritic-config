{ self, ... }:
{
  nixosHosts.mini.enable = true;
  flake.modules.nixos."confs/mini" =
    {
      config,
      ...
    }:
    {
      imports = with self.modules.nixos; [
        nix
        base
        dragon
      ];
      boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariable = true;
      };

      virtualisation.vmVariant.virtualisation = {
        memorySize = 4096;
        vores = 4;
      };

      services.xserver = {
        enable = true;
        desktopManager.lxqt.enable = true;
        displayManager.lightdm.enable = true;
      };
    };

  system.stateVersion = "25.11";
}
