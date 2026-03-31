{
  config,
  inputs,
  lib,
  ...
}:
{
  flake-file.inputs.nixos-wsl.url = lib.mkDefault "github:nix-community/NixOS-WSL";

  flake.modules.nixos."confs/wsl" = {
    imports = with config.flake.modules.nixos; [
      inputs.nixos-wsl.nixosModules.wsl

      base
      nix
    ];
  };
}
