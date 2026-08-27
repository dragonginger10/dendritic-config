{
  self,
  ...
}:
{
  nixpkgs.allowedUnfreePackages = [
    "claude-code"
  ];
  nixosHosts.phos.enable = true;

  flake.modules.nixos."confs/phos" =
    { pkgs, lib, ... }:
    {
      nixpkgs = {
        hostPlatform = lib.mkDefault "x86_64-linux";
        overlays = [ self.overlays.default ];
      };
      age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICsuTYhZ1XsXb+d/Pyph7RpkPYnE3R4xV9Usl5aH6Ood dragon@phos";

      imports = with self.modules.nixos; [
        base
        nix
        boot
        gaming
        dragon
        determinate
        displayManager
        desktop
        vm
        syncthing
        secrets
        avahi
      ];

      networking.firewall.enable = false;
      networking.networkmanager = {
        enable = true;
        plugins = with pkgs; [
          networkmanager-openvpn
        ];
      };

      environment.systemPackages = with pkgs; [
        ani-cli
        qbittorrent
        openhue-cli
        wtwitch
        twitch-tui
        nyaa
        proton-vpn
        protonmail-desktop
        gparted
      ];

      security.sudo.wheelNeedsPassword = false;

      system.stateVersion = "25.11";

    };
}
