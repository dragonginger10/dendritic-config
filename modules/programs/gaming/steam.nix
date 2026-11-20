{
  nixpkgs.allowedUnfreePackages = [
    "steam"
    "steam-original"
    "steam-unwrapped"
    "steam-run"
  ];

  flake.modules.nixos.steam =
    { pkgs, ... }:
    {
      hardware.graphics.enable = true;
      hardware.graphics.enable32Bit = true;
      programs = {
        gamemode.enable = true;
        steam = {
          enable = true;
          remotePlay.openFirewall = true;
          protontricks.enable = true;
          extraPackages = with pkgs; [
            steamtinkerlaunch
          ];
          extraCompatPackages = with pkgs; [
            steamtinkerlaunch
          ];
        };
      };
    };
}
