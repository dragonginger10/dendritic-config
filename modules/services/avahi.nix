{
  flake.modules.nixos.avahi = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      system-config-printer
    ];
    services = {
      printing.enable = true;
      avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };
    };
  };
}
