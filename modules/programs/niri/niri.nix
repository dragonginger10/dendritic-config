{
  self,
  inputs,
  ...
}:
{
  flake.modules.nixos.niri =
    {
      config,
      wlib,
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

      config.settings =
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
          layer-rules = [ ];
          window-rules = [ ];
          spawn-at-startup = [ ];
          input.keyboard = {
            xkb = {
              layout = "us";
              options = "caps:escape";
            };
          };

          binds = {
            "Mod+Return".spawn = getExe pref.terminal;

            "Mod+d".spawn-sh = let 
              menu = [
              {
                key = "d";
                desc = "discord";
                cmd = "${getExe pkgs.webcord}";
              }
              {
                key = "p";
                desc = "pulsemixer";
                cmd = "${getExe pkgs.ghostty} -e ${getExe pkgs.pulsemixer}";
              }
            ];
  in
      self.factory.mkWhichKeyExe config.pkgs menu;
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
