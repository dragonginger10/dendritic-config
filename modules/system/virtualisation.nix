{ config, ... }:
{
  flake.module.nixos.virtualisation = {

    config = {
      libvirtd.enable = true;
      docker.enable = true;

      user.users.${config.preferences.user.name}.extraGroups = [ "docker" ];
    };
  };
}
