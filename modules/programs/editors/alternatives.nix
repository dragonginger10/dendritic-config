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
      nvim = self'.packages.neovim;
      themed-nvim = nvim.extend config.stylix.targets.nixvim.exportModule;
    in
    {
      options.editors = {
        alternatives.enable = lib.mkEnableOption "Alternative editors";
      };

      config = {
        environment.systemPackages =
          with pkgs;
          [
            themed-nvim
          ]
          ++ lib.optional alts [
            evil-helix
            micro
          ];
      };
    };
}
