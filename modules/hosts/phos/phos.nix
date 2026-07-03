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
