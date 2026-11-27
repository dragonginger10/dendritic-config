{ self, ... }:
{
  nixosHosts.phos.enable = true;

  flake.modules.nixos."confs/phos" =
    { lib, ... }:
    {
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICsuTYhZ1XsXb+d/Pyph7RpkPYnE3R4xV9Usl5aH6Ood dragon@phos";

      imports = with self.modules.nixos; [
        base
        boot
        determinate
        dragon
        vm

        desktop
        displayManager
        niri
        eldritch-cursors
        wallpaperengine

        dev
        gaming
        media
        proton
        printing

        secrets
        syncthing
        wbtv
      ];

      networking.firewall.enable = false;
      networking.networkmanager.enable = true;

      security.sudo.wheelNeedsPassword = false;

      system.stateVersion = "25.11";
    };
}
