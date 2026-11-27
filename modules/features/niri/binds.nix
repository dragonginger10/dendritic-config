{
  # Core window-management binds. App launchers live in menus.nix / the owning feature.
  flake.modules.wrapper.niri =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      inherit (lib) getExe;
      none = _: { };
    in
    {
      settings.recent-windows.binds = {
        "Alt+Tab".next-window = none;
        "Alt+Shift+Tab".previous-window = none;
      };

      settings.binds = {
        # apps
        "Mod+Return".spawn = getExe config.preferences.niri.terminal;
        "Mod+E".spawn = getExe pkgs.cosmic-files;

        # session / overlays
        "Mod+Shift+E".quit = _: { props.skip-confirmation = true; };
        "Mod+Shift+Q".close-window = none;
        "Mod+Shift+Slash".show-hotkey-overlay = none;
        "Mod+Tab".toggle-overview = none;

        # columns & windows
        "Mod+Equal".set-column-width = "+10%";
        "Mod+Minus".set-column-width = "-10%";
        "Mod+F".maximize-column = none;
        "Mod+Shift+F".fullscreen-window = none;
        "Mod+C".center-column = none;
        "Mod+Space".toggle-window-floating = none;
        "Mod+Shift+Space".switch-focus-between-floating-and-tiling = none;

        # focus / move (vim keys + wheel)
        "Mod+H".focus-column-left = none;
        "Mod+J".focus-window-or-workspace-down = none;
        "Mod+K".focus-window-or-workspace-up = none;
        "Mod+L".focus-column-right = none;
        "Mod+Shift+H".move-column-left = none;
        "Mod+Shift+J".move-window-down-or-to-workspace-down = none;
        "Mod+Shift+K".move-window-up-or-to-workspace-up = none;
        "Mod+Shift+L".move-column-right = none;
        "Mod+WheelScrollDown".focus-window-or-workspace-down = none;
        "Mod+WheelScrollUp".focus-window-or-workspace-up = none;
        "Mod+Shift+WheelScrollDown".focus-column-right = none;
        "Mod+Shift+WheelScrollUp".focus-column-left = none;

        # monitors
        "Mod+M".focus-monitor-next = none;
        "Mod+Shift+M".move-workspace-to-monitor-next = none;
        "Mod+Shift+P".power-off-monitors = none;

        # screencast targets
        "Mod+Shift+R".set-dynamic-cast-window = none;
        "Mod+Ctrl+R".set-dynamic-cast-monitor = none;
        "Mod+Alt+R".clear-dynamic-cast-target = none;

        # screenshots
        "Mod+Shift+S".screenshot = none;
        "Print".screenshot-screen = none;

        # media keys
        "XF86AudioNext".spawn-sh = "${getExe pkgs.playerctl} next";
        "XF86AudioPlay".spawn-sh = "${getExe pkgs.playerctl} play-pause";
        "XF86AudioPrev".spawn-sh = "${getExe pkgs.playerctl} previous";
        "XF86AudioLowerVolume".spawn-sh = "${getExe pkgs.ponymix} decrease 1";
        "XF86AudioRaiseVolume".spawn-sh = "${getExe pkgs.ponymix} increase 1";
      };
    };
}
