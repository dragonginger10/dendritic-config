{
  inputs,
  self,
  lib,
  ...
}:
{
  flake-file.inputs.stylix.url = lib.mkDefault "github:nix-community/stylix";
  flake.modules = {
    nixos.stylix =
      { config, pkgs, ... }:
      {
        imports = [
          inputs.stylix.nixosModules.stylix
          self.modules.generic.constants
        ];
        stylix = {
          enable = true;
          base16Scheme = "${pkgs.base16-schemes}/share/themes/${config.preferences.theme}.yaml";
        };
      };
    homeManager.stylix = {
      stylix.targets = {
        ghostty.opacity.enable = false;
      };
    };
  };
}
