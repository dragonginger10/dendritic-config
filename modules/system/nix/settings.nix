{
  flake.modules.nixos.nix =
    {
      config,
      inputs,
      lib,
      ...
    }:
    {
      nix =
        let
          user = config.preferences.user.name;
        in
        {
          registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
          nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
          channel.enable = false;
          gc = {
            automatic = true;
            dates = "weekly";
          };
          optimise.automatic = true;
          settings = {
            experimental-features = "nix-command flakes";
            auto-optimise-store = true;
            warn-dirty = false;
            trusted-users = [
              user
              "root"
            ];
            substituters = [
              "https://cache.nixos.org"
              "https://install.determinate.systems"
              "https://nix-community.cachix.org"
            ];
            trusted-public-keys = [
              "cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM="
              "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            ];
          };
        };
    };
}
