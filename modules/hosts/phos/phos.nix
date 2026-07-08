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
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
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
        avahi
      ];

      environment.systemPackages = with pkgs; [
        ani-cli
        deluge
        openhue-cli
        wtwitch
        twitch-tui
        nyaa
      ];

      security.sudo.wheelNeedsPassword = false;

      system.stateVersion = "25.11";

    };
}
