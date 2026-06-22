{
  flake.modules.nixos =
    { config, ... }:
    {
      vfio =
        { pkgs, ... }:
        {
          boot = {
            kernelParams = [
              "amd_iommu=on"
              "kvm.ignore_msrs=1"
            ];
            kernelModuels = [
              "vfio"
              "vfio_iommu_type1"
              "vfio_pci"
            ];
          };

          programs.virt-manager.enable = true;

          qemu = {
            package = pkgs.qemu_kvm;
            runAsRoot = true;
            swtpm.enable = true;
            ovmf = {
              enable = true;
              packages = [ pkgs.OVMFFull.df ];
            };
          };

          users.users.${config.preferences.user.name}.extraGroups = [ "libvirtd" ];
        };
    };
}
