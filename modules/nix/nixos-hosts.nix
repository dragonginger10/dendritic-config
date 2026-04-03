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
  config.flake-file.inputs.nixpkgs-stable.url =
    lib.mkDefault "github:NixOS/nixpkgs/nixos-25.11-small";
  options.nixosHosts =
    with types;
    let
      nixosHostType = submodule {
        options = {
          enable = lib.mkEnableOption "configuration";
          system = mkOption {
            type = str;
            default = "x86_64-linux";
          };
          stable = mkOption {
            type = bool;
            default = true;
          };
          additionalModules = mkOption {
            type = listOf attrs;
            default = [ ];
          };

        };
      };
    in
    mkOption { type = attrsOf nixosHostType; };

  config.flake.nixosConfigurations =
    let
      mkHost =
        hostname: options:
        let
          nixpkgs' = if options.stable then inputs.nixpkgs else inputs.nixpkgs-stable;
        in
        if options.enable then
          (nixpkgs'.lib.nixosSystem {
            inherit (options) system;
            specialArgs.inputs = inputs;
            modules = [
              (config.flake.modules.nixos."confs/${hostname}" or { })
              { networking.hostName = hostname; }
            ]
            ++ options.additionalModules;
          })
        else
          null;
      hosts = lib.mapAttrs mkHost config.nixosHosts;
    in
    lib.filterAttrs (h: v: v != null) hosts;

}
