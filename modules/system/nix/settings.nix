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
          };
        };
    };
}
