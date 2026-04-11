{ inputs, lib, ... }:
{
  options.flake = inputs.flake-parts.lib.mkSubmoduleOptions {
    factory = lib.mkOption {
      type = lib.types.attrsOf lib.types.unspecified;
      default = { };
    };
  };
}
