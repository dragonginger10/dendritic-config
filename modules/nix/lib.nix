{ inputs, lib, ... }:
{
  options.flake = inputs.flake-parts.lib.mkSubmoduleOptions {
    lib = lib.mkOption {
      type = lib.types.attrsOf lib.types.unspecified;
      default = { };
    };
  };
}
