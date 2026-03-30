{
  nixpkgs.allowedUnfreePackages = [
    "steam"
    "steam-original"
    "steam-unwrapped"
    "steam-run"
  ];

  flake.modules.nixos.steam = {
    hardware.graphics.enable = true;
    hardware.graphics.enable32bit = true;
    programs = {
      gamemode.enable = true;
      steam = {
        enable = true;
        remotePlat.openFirewall = true;
      };
    };
  };
}
