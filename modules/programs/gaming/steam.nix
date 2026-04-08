{
  nixpkgs.allowedUnfreePackages = [
    "steam"
    "steam-original"
    "steam-unwrapped"
    "steam-run"
  ];

  flake.modules.nixos.steam = {
    hardware.graphics.enable = true;
    hardware.graphics.enable32Bit = true;
    programs = {
      gamemode.enable = true;
      steam = {
        enable = true;
        remotePlay.openFirewall = true;
      };
    };
  };
}
