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
      themed-nvim = pkgs.local.neovim.extend config.stylix.targets.nixvim.exportedModule;
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
            local.micro
          ];
      };
    };
}
