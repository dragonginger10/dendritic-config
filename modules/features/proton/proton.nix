{ self, ... }:
{
  flake.modules = {
    nixos.proton =
      { config, pkgs, ... }:
      {
        networking.networkmanager.plugins = [ pkgs.networkmanager-openvpn ];

        home-manager.users.${config.preferences.user.name}.imports = [
          self.modules.homeManager.proton
        ];
      };

    homeManager.proton =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          proton-pass
          proton-vpn
          protonmail-desktop
        ];
      };
  };
}
