{
  self,
  lib,
  ...
}:
let
  username = "cinnabar";
in
{
  flake.modules = lib.mkMerge [
    (self.lib.user username true)
    {
      nixos.${username} = {
        imports = with self.modules.nixos; [
          basics
        ];
      };
    }
  ];
}
