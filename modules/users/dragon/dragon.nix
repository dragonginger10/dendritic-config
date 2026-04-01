{
  inputs,
  self,
  lib,
  ...
}:
let
  username = "dragon";
in
{
  flake.modules = lib.mkMerge [
    (self.factory.user username true)
    # { nixos.${username} = {pkgs,...}: {}; }
  ];
}
