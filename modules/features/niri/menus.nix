{ self, ... }:
{
  # which-key popup menus. Any feature can add an entry:
  #   flake.modules.wrapper.niri.menus."Mod+d".b = { desc = "browser"; cmd = "zen"; };
  # Entries are keyed by letter, so two features claiming the same key is an eval error.
  flake.modules.wrapper.niri =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      inherit (lib) getExe mkOption types;
      entry = types.submodule {
        options = {
          desc = mkOption { type = types.str; };
          cmd = mkOption { type = types.str; };
        };
      };
    in
    {
      options.menus = mkOption {
        type = types.attrsOf (types.attrsOf entry);
        default = { };
        description = "bind -> key -> which-key entry";
      };

      config = {
        settings.binds = lib.mapAttrs (_: entries: {
          spawn-sh = self.lib.mkWhichKeyExe config.pkgs (
            lib.mapAttrsToList (key: e: {
              inherit key;
              inherit (e) desc cmd;
            }) entries
          );
        }) config.menus;

        menus."Mod+d" = {
          p = {
            desc = "pulsemixer";
            cmd = "${getExe config.preferences.niri.terminal} -e ${getExe pkgs.pulsemixer}";
          };
          y = {
            desc = "Youtube";
            cmd = "flatpak run rocks.shy.VacuumTube";
          };
        };
      };
    };
}
