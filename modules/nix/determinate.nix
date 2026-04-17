{ inputs, ... }:
{
  flake-file.inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
    determinate = {
      url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.modules.nixos.determinate = {
    imports = [ inputs.determinate.nixosModules.default ];
  };
}
