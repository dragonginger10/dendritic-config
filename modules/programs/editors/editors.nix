{ self, ... }:
{
  flake.modules.nixos.editors =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      alts = config.editors.alternatives.enable;
      nvim = self.packages.${pkgs.system}.neovim;
      themed-nvim = nvim.extend config.stylix.targets.nixvim.exportedModule;
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
          ++ lib.optionals alts [
            evil-helix
            micro
          ];
      };
    };
}
