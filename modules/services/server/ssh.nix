{
  flake.modules.nixos.ssh = {
    services.openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        # Key-only: hoseki is internet-facing.
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
    };
  };
}
