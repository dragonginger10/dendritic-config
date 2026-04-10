{ inputs, lib, ... }:
{
  flake-file.inputs.stylix.url = lib.mkDefault "github:nix-community/stylix";
  flake.modules.nixos.stylix =
    { pkgs, ... }:
    {
      imports = [ inputs.stylix.nixosModules.stylix ];
      stylix =
        let
          theme = "eldritch";
        in
        {
          enable = true;
          base16Scheme = "${pkgs.base16-schemes}/share/themes/${theme}.yaml";
        };
    };
}
