{ pkgs, lib, ... }:
{
  flake.factory.mkWhichKey =
    menu:
    let
      configFile = pkgs.writeText "config.yaml" (
        lib.generators.toYAML { } {
          anchor = "bottom right";
          inherit menu;
        }
      );
    in
    pkgs.writeShellScriptBin "keyMenu" ''
      exec ${lib.getExe pkgs.wlr-which-key} ${configFile}
    '';
}
