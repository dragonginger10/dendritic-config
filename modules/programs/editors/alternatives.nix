{
  flake.modules.nixos.editors =
    {
      config,
      lib,
      pkgs,
      self',
      ...
    }:
    let
      alts = config.editors.alternatives.enable;
    in
    {
      options.editors = {
        alternatives.enable = lib.mkEnableOption "Alternative editors";
      };

      config = {
        environment.systemPackages =
          with pkgs;
          [
            self'.packages.neovim
          ]
          ++ lib.optional alts [
            evil-helix
            micro
          ];
      };
    };
}
