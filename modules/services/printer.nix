{
  nixpkgs.allowedUnfreePackages = [
    "cnijfilter2"
  ];
  flake.modules.nixos.avahi = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      system-config-printer
    ];
    services = {
      printing = {
        enable = true;
        drivers = with pkgs; [ cnijfilter2 ];
      };
      avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };
    };
  };
}
