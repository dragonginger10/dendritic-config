{ inputs, ... }:
{
  imports = [
    inputs.flake-file.flakeModules.dendritic
    inputs.flake-parts.flakeModules.modules
  ];
}
