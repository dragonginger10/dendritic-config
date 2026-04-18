{ self, ... }:
{
  flake.modules.homeManager.shell.imports = with self.modules.homeManager; [
    nushell
    git
    tmux
  ];
}
