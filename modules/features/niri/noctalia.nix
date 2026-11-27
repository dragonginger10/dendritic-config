{
  # noctalia desktop shell (bar, launcher, lock, wallpaper, screen recorder).
  flake.modules.nixos.niri =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        noctalia
        mpvpaper
        gpu-screen-recorder-gtk
      ];
      programs.gpu-screen-recorder.enable = true;
    };

  flake.modules.wrapper.niri =
    { lib, ... }:
    let
      msg =
        cmd:
        [
          "noctalia"
          "msg"
        ]
        ++ lib.splitString " " cmd;
      recorder = action: "noctalia-shell ipc call plugin:screen-recorder ${action}";
    in
    {
      settings = {
        spawn-at-startup = [ "noctalia" ];

        layer-rules = [
          {
            matches = [ { namespace = "^noctalia-wallpaper"; } ];
            place-within-backdrop = true;
          }
        ];

        binds = {
          "Mod+Ctrl+L".spawn = msg "session lock";
          "Mod+R".spawn = msg "panel-open launcher";
        };
      };

      menus."Mod+S" = {
        r = {
          desc = "toggle recording";
          cmd = recorder "toggle";
        };
        a = {
          desc = "toggle replay";
          cmd = recorder "toggleReplay";
        };
        s = {
          desc = "save replay";
          cmd = recorder "saveReplay";
        };
      };
    };
}
