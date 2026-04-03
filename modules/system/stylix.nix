{ inputs, lib, ... }:
{
  flake-file.inputs.stylix.url = lib.mkDefault "github:nix-community/stylix";
  flake.modules.nixos.stylix =
    { pkgs, ... }:
    {
      imports = [ inputs.stylix.nixosModules.stylix ];
      stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";
      };
    };
}
