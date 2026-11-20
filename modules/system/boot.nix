{
  flake.modules.nixos.boot = {
    boot.loader = {
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot/efi";
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        configurationLimit = 10;
      };
    };
  };
}
