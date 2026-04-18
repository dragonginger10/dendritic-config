{
  flake.modules.nixos.vm = {
    virtualisation.vmVariantWithBootLoader = {
      virtualisation = {
        memorySize = 4096;
        cores = 4;
      };
    };
  };
}
