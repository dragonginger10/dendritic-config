{
  nixpkgs.allowedUnfreePackages = [
    "discord"
  ];

  flake.modules.homeManager.gui =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        mattermost-desktop
        feh
        nautilus
        discover-overlay
        mpv
        calibre
        noctalia-shell
      ];

      programs = {
        discord.enable = true;
        ghostty = {
          enable = true;
          settings = {
            background-opacity = 0.85;
            font-size = 12;
          };
        };
      };
    };
}
