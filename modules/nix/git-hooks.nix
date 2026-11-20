{ inputs, lib, ... }:
{
  flake-file.inputs.git-hooks-nix.url = lib.mkDefault "github:cachix/git-hooks.nix";
  imports = [ inputs.git-hooks-nix.flakeModule ];

  perSystem.pre-commit = {
    check.enable = true;
    settings = {
      hooks = {
        nixfmt.enable = true;
        statix.enable = true;
        nufmt = {
          enable = true;
          types = [ "file" ];
        };
      };
    };
  };
}
