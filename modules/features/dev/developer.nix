{
  nixpkgs.allowedUnfreePackages = [ "claude-code" ];

  flake.modules = {
    # System support for running non-Nix binaries and ~/.local/bin tools.
    nixos.dev = {
      environment.localBinInPath = true;
      programs = {
        fuse.enable = true;
        nix-ld.enable = true;
      };
    };

    homeManager.developer =
      { pkgs, ... }:
      {
        programs.lazygit.enable = true;
        home.packages = with pkgs; [
          claude-code
          devenv
          opencode
        ];
      };
  };
}
