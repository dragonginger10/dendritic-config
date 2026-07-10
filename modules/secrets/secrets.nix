{
  flake.modules.nixos.secrets =
    { config, ... }:
    let
      username = config.preferences.user.name;
    in
    {
      secrets = {
        cloudapi = {
          rekeyFile = ./cloudapi.age;
          mode = "770";
          owner = username;
          group = "users";
        };
        linode = {
          rekeyFile = ./linode.age;
          mode = "770";
          owner = username;
          group = "users";
        };
      };
    };
}
