{ self, ... }:
{
  flake.modules.homeManager.shell.imports = with self.module.homeManager; [
    nushell
    git
  ];
}
