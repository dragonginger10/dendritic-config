{ inputs, ... }:
{
  # imports = [];
  perSystem =
    { pkgs, system, ... }:
    {
      devShells.default = pkgs.mkShell {
        NIX_CONFIG = "experimental-features = nix-command flakes pipe-operators";
        packages = with pkgs; [
          inputs.ragenix.packages.${system}.ragenix
          nh
          just
          nixd
          statix
          home-manager
          jujutsu
        ];
      };
    };
}
