{ self, ... }:
{
  flake.modules.nixos = {
    # Minimal system-wide toolset (root, recovery, non-HM users) + default shell.
    basics =
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
            git
            just
            nh
            unzip
            wget
            zip
          ];

          environment.shells = [ cfg.default ] ++ cfg.extraShells;

          users.defaultUserShell = cfg.default;
        };
      };

    # Full CLI environment. Tools with HM `programs.*` modules
    # (bat, btop, fzf, ripgrep, yazi, zoxide) live in the user's HM config.
    environment =
      { pkgs, ... }:
      {
        imports = [ self.modules.nixos.basics ];

        environment.systemPackages = with pkgs; [
          duf
          dust
          gping
          jujutsu
          nix-output-monitor
          procs
          sd
          tealdeer
        ];
      };
  };
}
