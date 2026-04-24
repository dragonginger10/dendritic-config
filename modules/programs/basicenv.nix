{
  flake.modules.nixos.basics =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      cfg = config.preferences.shell;
    in
    {
      options.preferences.shell = with lib; {
        default = mkOption {
          type = types.package;
          default = pkgs.nushell;
        };
        extraShells = mkOption {
          type = types.listOf types.package;
          default = [ ];
        };
      };

      config = {

        environment.systemPackages = with pkgs; [
          bat
          btop
          git
          just
          unzip
          wget
          zip
          zoxide
        ];

        environment.shells = [ cfg.default ] ++ cfg.extraShells;

        users.defaultUserShell = cfg.default;
      };
    };
}
