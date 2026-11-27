{ self, ... }:
{
  flake.modules.nixos.base.imports = with self.modules; [
    generic.constants
    nixos.nix
  ];
}
