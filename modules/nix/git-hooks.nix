{inputs, ...}: {
  flake-file.inputs.git-hooks-nix.url = "github:cachix/git-hooks.nix";
  imports = [inputs.git-hooks-nix.flakeModule];

  perSystem.pre-commit = { 
    check.enable = true;
    settings = {
      hooks.nixfmt.enable = true;
    };
  };
}
