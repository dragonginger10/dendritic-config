{
  self,
  ...
}:
{
  nixosHosts.wonderland.enable = true;

  flake.modules.nixos."confs/wonderland" =
    { pkgs, lib, ... }:
    {
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      imports = with self.modules.nixos; [
        base
        nix
        dragon
        desktop
        determinate
      ];

      boot.loader.systemd-boot.enable = true;

      environment.systemPackages = with pkgs; [
        slack
      ];

      services = {
        displayManager = {
          enable = true;
          cosmic-greeter.enable = true;
        };
        desktopManager = {
          cosmic.enable = true;
        };
      };

      programs.niri.enable = lib.mkForce false;

      security.sudo.wheelNeedsPassword = false;

      system.stateVersion = "25.11";

    };
}
