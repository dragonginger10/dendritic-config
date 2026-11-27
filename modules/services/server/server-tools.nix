{
  flake.modules.nixos.server-tools =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        inetutils
        lazydocker
        mtr
        sysstat
      ];
    };
}
