{
  flake.modules.nixos.environment =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      cfg = config.myShell;
    in
    {
      options.myShell = with lib; {
        shell = mkOption {
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
          df
          duf
          dust
          fzf
          git
          gping
          jujutsu
          just
          nh
          nix-output-monitor
          procs
          ripgrep
          sd
          tealdeer
          unzip
          wget
          yazi
          zip
        ];

        environment.shells = [ cfg.shell ] ++ cfg.extraShells;

        users.defaultUserShell = cfg.shell;
      };
    };
}
