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
      alts = config.preferences.editors.alternatives.enable;
      selfpkgs = self.packages.${pkgs.stdenv.hostPlatform.system};
      themed-nvim = selfpkgs.nvim.extend config.stylix.targets.nixvim.exportedModule;
    in
    {
      options.preferences.editors = {
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
            selfpkgs.micro
          ];
      };
    };
}
