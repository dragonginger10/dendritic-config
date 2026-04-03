{
  inputs,
  self,
  lib,
  ...
}:
let
  username = "dragon";
in
{
  flake.modules = lib.mkMerge [
    (self.factory.user username true)
    # {
    #   nixos.${username} = {pkgs,...}: {
    #     imports = with self.modules.nixos; [];
    #   };
    # }
    # {
    #   homeManager.${username} = {pkgs,...}: {
    #     imports = with self.modules.homeManager; [];
    #     home.packages = with pkgs; [];
    #   };
    # }
  ];
}
