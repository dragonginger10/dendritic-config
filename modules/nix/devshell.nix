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
          nix-update
          nix-init
          statix
          home-manager
          jujutsu
          config.agenix-rekey.package
        ];
        shellHook = ''
          ${config.pre-commit.shellHook}
          echo 1>&2 "Entered devshell"
        '';
      };
    };
}
