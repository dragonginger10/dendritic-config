{ self, ... }:
{
  nixosHosts.wonderland.enable = true;

  flake.modules.nixos."confs/wonderland" =
    { lib, ... }:
    {
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      imports = with self.modules.nixos; [
        base
        determinate
        dragon
        desktop
        work
      ];

      boot.loader.systemd-boot.enable = true;

      services = {
        displayManager = {
          enable = true;
          cosmic-greeter.enable = true;
        };
        desktopManager.cosmic.enable = true;
      };

      security.sudo.wheelNeedsPassword = false;

      system.stateVersion = "25.11";
    };
}
