{
  flake.modules.homeManager.developer =
    { pkgs, ... }:
    {
      config = {
        programs = {
          lazygit.enable = true;
        };
        home.packages = with pkgs; [
          devenv
          claude-code
          opencode
        ];
      };
    };
}
