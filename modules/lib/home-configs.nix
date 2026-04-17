{
  inputs,
  lib,
  config,
  ...
}:
let
  inherit (lib) types mkOption;
in
{
  options.homeConfigs =
    with types;
    let
      homeConfigType = submodule {
        options = {
          enable = lib.mkEnableOption "configuration";
          additionalModules = mkOption {
            type = listOf attrs;
            default = [ ];
          };

        };
      };
    in
    mkOption { type = attrsOf homeConfigType; };

  config.flake.homeConfigurations =
    let
      mkUser =
        user: options:
        if options.enable then
          (inputs.home-manager.lib.homeManagerConfiguration {
            pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
            modules = [
              (config.flake.modules.homeManager.${user} or { })
              {
                home = {
                  username = user;
                  homeDirectory = "/home/${user}";
                };
              }
            ]
            ++ options.additionalModules;
          })
        else
          null;
      userConfigs = lib.mapAttrs mkUser config.homeConfigs;
    in
    lib.filterAttrs (h: v: v != null) userConfigs;
}
