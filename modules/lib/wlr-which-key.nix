{
  inputs,
  self,
  lib,
  ...
}:
let
  inherit (inputs.wrappers.lib) wrapModule;
  mkWhichKey =
    pkgs: menu:
    self.wrapModules.which-key.wrap {
      inherit pkgs;
      settings = {
        inherit menu;
        anchor = "bottom-right";
      };
    };
in
{
  flake.lib.mkWhichKeyExe = pkgs: menu: lib.getExe (mkWhichKey pkgs menu);

  flake.wrapModules.which-key = wrapModule (
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      yamlFormat = pkgs.formats.yaml { };
    in
    {
      options.settings = lib.mkOption {
        inherit (yamlFormat) type;
        description = "The keymap";
      };

      config = {
        package = config.pkgs.wlr-which-key;
        addFlag = [
          (toString (yamlFormat.generate "config.yaml" config.settings))
        ];
      };
    }
  );
}
