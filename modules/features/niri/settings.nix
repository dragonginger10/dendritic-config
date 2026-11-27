{
  flake.modules.wrapper.niri.settings = {
    prefer-no-csd = true;
    hotkey-overlay.hide-not-bound = true;

    layout = {
      always-center-single-column = true;
      empty-workspace-above-first = true;
    };

    outputs."Lenovo Group Limited Legion Glass2 0x00000011".scale = 1;

    input.keyboard.xkb = {
      layout = "us";
      options = "caps:escape";
    };

    spawn-at-startup = [ "xwayland-satellite" ];

    window-rules = [
      {
        matches = [
          {
            is-active = false;
            is-floating = true;
          }
        ];
        opacity = 0.5;
      }
      {
        matches = [
          {
            app-id = "steam";
            title = "^notificationtoats_\d+_desktop%";
          }
        ];
        default-floating-position = _: {
          props = {
            x = 10;
            y = 10;
            relative-to = "bottom-right";
          };
        };
      }
      {
        matches = [ { is-window-cast-target = true; } ];
        focus-ring = {
          active-color = "#f38ba8";
          inactive-color = "#7a5935";
        };
        border.inactive-color = "#7d0d2d";
        shadow.color = "#7d0d2d70";
        tab-indicator = {
          active-color = "#ffb86c";
          inactive-color = "#7a5935";
        };
      }
    ];
  };
}
