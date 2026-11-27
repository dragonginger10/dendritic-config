{
  nixpkgs.allowedUnfreePackages = [
    "steam"
    "steam-original"
    "steam-unwrapped"
    "steam-run"
  ];

  flake.modules.nixos.steam =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      options.preferences.steam.library = lib.mkOption {
        type = lib.types.str;
        default = "${config.users.users.${config.preferences.user.name}.home}/.local/share/Steam";
        description = "Steam library root (the directory containing steamapps/).";
      };

      config = {
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
    };
}
