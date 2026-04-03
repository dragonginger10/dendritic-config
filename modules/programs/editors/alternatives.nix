{
  flake.modules.nixos.editors =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      options.editors = {
        alternatives.enable = lib.mkEnableOption "Alternative editors";
      };

      config = lib.mkIf config.editors.alternatives.enable {
        environment.systemPackages = with pkgs; [
          evil-helix
          micro
        ];
      };
    };
}
