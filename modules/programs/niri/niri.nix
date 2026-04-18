{
  self,
  inputs,
  ...
}:
{

  flake.modules.nixos.niri =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      options.preferences.niri = with lib; {
        terminal = mkOption {
          type = types.package;
          default = pkgs.ghostty;
        };
      };

      config = {
        v2-settings = true;
        settings =
          let
            inherit (lib) getExe;
            pref = config.preferences.niri;
          in
          {
            prefer-no-csd = true;
            hotkey-overlay.hide-not-bound = true;
            layout = {
              always-center-single-column = true;
              empty-workspace-above-first = true;
            };
            layer-rules = [
              {
                matches = [ { namespace = "^noctalia-overview"; } ];
                place-within-backdrop = true;
              }
            ];

            window-rules = [
              {
                matches = [ { is-window-cast-target = true; } ];
                focus-ring = {
                  active-color = "#ffb86c";
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
            spawn-at-startup = with pkgs; [
              "noctalia-shell"
              "xwayland-satellite"
            ];
            input.keyboard = {
              xkb = {
                layout = "us";
                options = "caps:escape";
              };
            };

            recent-windows = {
              binds = {
                "Alt+Tab".next-window = _: { };
                "Alt+Shift+Tab".previous-window = _: { };
              };
            };

            binds =
              let
                noctalia =
                  cmd:
                  [
                    "noctalia-shell"
                    "ipc"
                    "call"
                  ]
                  ++ (lib.splitString " " cmd);
                mkMenu = self.lib.mkWhichKeyExe config.pkgs;
              in
              {
                "Mod+Return".spawn = getExe pref.terminal;
                "Mod+Equal".set-column-width = "+10%";
                "Mod+F".maximize-column = _: { };
                "Mod+Minus".set-column-width = "-10%";
                "Mod+Shift+E".quit = _: {
                  props = {
                    "skip-confirmation" = true;
                  };
                };
                "Mod+Shift+F".fullscreen-window = _: { };
                "Mod+Shift+Q".close-window = _: { };
                "Mod+Shift+Slash".show-hotkey-overlay = _: { };
                "Mod+Shift+Space".switch-focus-between-floating-and-tiling = _: { };
                "Mod+Space".toggle-window-floating = _: { };
                "Mod+Shift+P".power-off-monitors = _: { };

                "Mod+Ctrl+L" = {
                  spawn = noctalia "lockScreen lock";
                };
                "Mod+E" = {
                  spawn = "${getExe pkgs.cosmic-files}";
                };
                "Mod+R".spawn = noctalia "launcher toggle";

                "Mod+d".spawn-sh =
                  let
                    menu = with pkgs; [
                      {
                        key = "d";
                        desc = "discord";
                        cmd = "discord";
                      }
                      {
                        key = "p";
                        desc = "pulsemixer";
                        cmd = "${getExe ghostty} -e ${getExe pulsemixer}";
                      }
                      {
                        key = "b";
                        desc = "browser";
                        cmd = "zen";
                      }
                      {
                        key = "o";
                        desc = "discord overlay";
                        cmd = "discover-overlay";
                      }
                      {
                        key = "m";
                        desc = "mattermost";
                        cmd = "${getExe pkgs.mattermost-desktop}";
                      }
                      {
                        key = "y";
                        desc = "Youtube";
                        cmd = "flatpak run rocks.shy.VacuumTube";
                      }
                    ];
                  in
                  mkMenu menu;
                "Mod+O".spawn-sh =
                  let
                    menu = with pkgs; [
                      {
                        key = "d";
                        desc = "deafen discord";
                        cmd = "discover-overlay --rpc --toggle-deaf";
                      }
                      {
                        key = "m";
                        desc = "mute discord";
                        cmd = "discover-overlay --rpc --toggle-mute";
                      }
                      {
                        key = "x";
                        desc = "close overlay";
                        cmd = "discover-overlay --rpc --close";
                      }
                    ];
                  in
                  mkMenu menu;
                "Mod+S".spawn-sh = let
                  menu = [
                    {
                      key = "r";
                      desc = "toggle recording";
                      cmd = "noctalia-shell ipc call plugin:screen-recorder toggle";
                    }
                    {
                      key = "a";
                      desc = "toggle replay";
                      cmd = "noctalia-shell ipc call plugin:screen-recorder toggleReplay";
                    }
                    {
                      key = "s";
                      desc = "save replay";
                      cmd = "noctalia-shell ipc call plugin:screen-recorder saveReplay";
                    }
                  ];
                in
                  mkMenu menu;

                "XF86AudioNext".spawn = "${getExe pkgs.playerctl} next";
                "XF86AudioPlay".spawn = "${getExe pkgs.playerctl} play-pause";
                "XF86AudioPrev".spawn = "${getExe pkgs.playerctl} previous";
                "XF86AudioLowerVolume".spawn = "${getExe pkgs.ponymix} decrease 1";
                "XF86AudioRaiseVolume".spawn = "${getExe pkgs.ponymix} increase 1";
                "Mod+Shift+S".screenshot = _: { };
                "Print".screenshot-screen = _: { };
                "Mod+C".center-column = _: { };
                "Mod+Tab".toggle-overview = _: { };
                "Mod+H".focus-column-left = _: { };
                "Mod+J".focus-window-or-workspace-down = _: { };
                "Mod+K".focus-window-or-workspace-up = _: { };
                "Mod+L".focus-column-right = _: { };
                "Mod+Shift+H".move-column-left = _: { };
                "Mod+Shift+J".move-window-down-or-to-workspace-down = _: { };
                "Mod+Shift+K".move-window-up-or-to-workspace-up = _: { };
                "Mod+Shift+L".move-column-right = _: { };

                "Mod+WheelScrollDown".focus-window-or-workspace-down = _: { };
                "Mod+WheelScrollUp".focus-window-or-workspace-up = _: { };
                "Mod+Shift+WheelScrollDown".focus-column-right = _: { };
                "Mod+Shift+WheelScrollUp".focus-column-left = _: { };
              };
          };
      };
    };

  perSystem =
    { pkgs, ... }:
    {
      packages.niri = inputs.wrappers.wrappers.niri.wrap {
        inherit pkgs;
        imports = [
          self.modules.nixos.niri
        ];
      };
    };
}
