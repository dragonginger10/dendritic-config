{
  nixpkgs.allowedUnfreePackages = [
    "discord"
    "discord-unwrapped"
  ];

  flake.modules.homeManager.gui =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        mattermost-desktop
        mupdf
        feh
        nautilus
        discover-overlay
        mpv
        spotatui
        calibre
      ];

      programs = {
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
