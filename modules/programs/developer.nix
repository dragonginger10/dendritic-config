{
  flake.modules.homeManager.developer =
    { pkgs, ... }:
    {
      config = {
        home.packages = with pkgs; [
          devenv
          claude-code
          opencode
        ];
      };
    };
}
