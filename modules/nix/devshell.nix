{
  # imports = [];
  perSystem =
    {
      inputs',
      pkgs,
      config,
      ...
    }:
    {
      devShells.default = pkgs.mkShell {
        NIX_CONFIG = "experimental-features = nix-command flakes pipe-operators";
        packages = with pkgs; [
          nh
          just
          nixd
          statix
          home-manager
          jujutsu
        ];
        shellHook = ''
          ${config.pre-commit.shellHook}
          echo 1>&2 "Entered devshell"
        '';
      };
    };
}
